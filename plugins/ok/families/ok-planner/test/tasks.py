#!/usr/bin/env python3
"""Primitive tests for the task tracker at scripts/tasks.

Every test runs the vendored script as a consumer would, in a scratch
project, and asserts on what running it produced: the instruction
`next` prints, the records the run holds, and the events it emitted.
"""
import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
TASKS = os.path.join(HERE, "..", "scripts", "tasks")
CONVERGE = os.path.join(HERE, "..", "admin", "converge")

AGENTS = {"planner": ("sonnet", "high"), "builder": ("opus", "high"), "reviewer": ("opus", "high"),
          "lookup": ("haiku", "low")}
PROMPT_NAMES = ("plan", "build", "review", "judge")
PROMPTS = {name: ".ok-planner/prompts/%s.md" % name for name in PROMPT_NAMES}
REGISTRY = {"agents": sorted(AGENTS), "prompts": PROMPTS}


def write_agent(root, name, model, effort, stamped=False):
    os.makedirs(os.path.join(root, ".claude", "agents"), exist_ok=True)
    with open(os.path.join(root, ".claude", "agents", name + ".md"), "w") as f:
        f.write("---\nname: %s\ndescription: \"test profile\"\nmodel: %s\neffort: %s\n---\n\nClaim and close.\n"
                % (name, model, effort))
        if stamped:
            f.write("\n<!-- Materialized by ok-planner v0 -->\n")


class Project:
    def __init__(self, registry=REGISTRY):
        self.root = tempfile.mkdtemp(prefix="ok-tasks-")
        os.makedirs(os.path.join(self.root, ".ok-planner", "prompts"))
        for name in PROMPT_NAMES:
            with open(os.path.join(self.root, ".ok-planner", "prompts", name + ".md"), "w") as f:
                f.write("You are the %s.\n" % name)
        for name, (model, effort) in AGENTS.items():
            write_agent(self.root, name, model, effort)
        path = os.path.join(self.root, "registry.json")
        with open(path, "w") as f:
            json.dump(registry, f)
        self.out("init", "run", "--registry", path)

    def close(self):
        shutil.rmtree(self.root, ignore_errors=True)

    def run(self, *args, check=True, stdin=None, env=None):
        full_env = dict(os.environ, OK_PLANNER_PROJECT_ROOT=self.root)
        full_env.update(env or {})
        proc = subprocess.run([sys.executable, TASKS] + list(args), cwd=self.root, env=full_env,
                              capture_output=True, text=True, input=stdin or "", timeout=30)
        if check and proc.returncode != 0:
            raise AssertionError("tasks %s failed (%d): %s%s"
                                 % (" ".join(args), proc.returncode, proc.stdout, proc.stderr))
        return proc

    def out(self, *args, **kw):
        return self.run(*args, **kw).stdout.strip()

    def err(self, *args):
        return self.run(*args, check=False).stderr

    def json(self, *args):
        return json.loads(self.out(*args))

    def next(self, *flags):
        return self.json("next", "--json", *flags)

    def one(self, *flags):
        instructions = self.next(*flags)
        assert len(instructions) == 1, instructions
        return instructions[0]

    def file(self, role, prompt="build", agent="builder", *extra, **kw):
        return self.out("file", "--role", role, "--prompt", prompt, "--agent", agent, *extra, **kw)

    def records(self, rtype):
        return [json.loads(l) for l in self.out("dump", "--type", rtype).split("\n") if l.strip()]

    def tasks(self):
        return {t["id"]: t for t in self.records("task")}

    def events(self, kind=None):
        return [e for e in self.records("event") if kind is None or e["kind"] == kind]

    def items(self, pool, **kw):
        args = ["item", "list", "--pool", pool, "--json"]
        for k, v in kw.items():
            args += ["--" + k, v]
        return self.json(*args)


class PrimitiveTests(unittest.TestCase):
    def setUp(self):
        self.p = Project()

    def tearDown(self):
        self.p.close()

    def test_init_use_and_pointer(self):
        p = self.p
        pointer = os.path.join(p.root, ".ok-planner", ".cache", "current")
        self.assertEqual(open(pointer).read().strip(), ".ok-planner/tasks/run.jsonl")
        self.assertEqual(open(os.path.join(p.root, ".ok-planner", ".cache", ".gitignore")).read().strip(), "*")
        p.out("init", "other", "--file", ".ok-planner/sprints/other-tasks.jsonl")
        self.assertEqual(open(pointer).read().strip(), ".ok-planner/sprints/other-tasks.jsonl")
        self.assertEqual(p.json("status", "--json")["run"]["name"], "other")
        p.out("use", ".ok-planner/tasks/run.jsonl")
        self.assertEqual(p.json("status", "--json")["run"]["name"], "run")
        self.assertIn("exists", p.err("init", "run"))
        self.assertIn("no such run file", p.err("use", "nope.jsonl"))
        self.assertEqual(sorted(os.listdir(os.path.join(p.root, ".ok-planner", "tasks"))), ["run.jsonl"])

    def test_registry_agents_prompts_and_config(self):
        p = self.p
        agents = {a["id"]: a for a in p.records("agent")}
        self.assertEqual((agents["reviewer"]["model"], agents["reviewer"]["effort"], agents["reviewer"]["path"]),
                         ("opus", "high", ".claude/agents/reviewer.md"))
        prompts = {x["id"]: x for x in p.records("prompt")}
        self.assertEqual(prompts["build"]["path"], ".ok-planner/prompts/build.md")
        write_agent(p.root, "fixer", "opus", "max")
        p.out("agent", "register", "fixer")
        self.assertEqual({a["id"]: (a["model"], a["effort"]) for a in p.records("agent")}["fixer"], ("opus", "max"))
        p.out("prompt", "register", "fix", ".ok-planner/prompts/build.md")
        self.assertIn("fix", {x["id"] for x in p.records("prompt")})
        self.assertIn("no agent file at .claude/agents/ghost.md", p.err("agent", "register", "ghost"))
        self.assertIn("prompt file not found", p.err("prompt", "register", "nope", "missing.md"))
        p.out("config", "set", "staged_pool", "files")
        p.out("config", "set", "cap", "8")
        self.assertEqual(p.json("status", "--json")["run"]["config"], {"staged_pool": "files", "cap": 8})
        extra = os.path.join(p.root, "extra.json")
        write_agent(p.root, "judge", "opus", "xhigh")
        with open(extra, "w") as f:
            json.dump({"agents": ["judge"], "config": {"cap": 3}}, f)
        p.out("registry", "load", extra)
        self.assertIn("judge", {a["id"] for a in p.records("agent")})
        self.assertEqual(p.json("status", "--json")["run"]["config"]["cap"], 3)

    def test_file_validates_the_task(self):
        p = self.p
        self.assertIn("names a prompt", p.err("file", "--agent", "builder"))
        self.assertIn("names an agent profile", p.err("file", "--prompt", "build"))
        self.assertIn("no agent profile ghost", p.err("file", "--prompt", "build", "--agent", "ghost"))
        self.assertIn("no prompt ghost", p.err("file", "--prompt", "ghost", "--agent", "builder"))
        self.assertIn("names a command", p.err("file", "--kind", "exec"))
        tid = p.file("build", "build", "builder", "--brief", "-", "--files", "a.py", "b.py",
                     "--cites", "story:x", "--key", "s1", "--consumes", "specs", "findings:*:s2", "files:unread:",
                     stdin="from stdin\n")
        t = p.tasks()[tid]
        self.assertEqual((t["state"], t["issued"], t["brief"], t["files"], t["cites"], t["key"]),
                         ("open", 0, "from stdin\n", ["a.py", "b.py"], ["story:x"], "s1"))
        self.assertEqual(t["consumes"], [{"pool": "specs", "state": "open"},
                                         {"pool": "findings", "state": "*", "key": "s2"},
                                         {"pool": "files", "state": "unread"}])
        self.assertEqual(p.events("TASKS.TASK.FILED")[-1]["task"], tid)

    def test_after_is_validated_at_file_time(self):
        p = self.p
        self.assertIn("waits on t9, which does not exist", p.err("file", "--prompt", "build", "--agent", "builder",
                                                                  "--after", "t9"))
        self.assertIn("cannot wait on itself", p.err("file", "--prompt", "build", "--agent", "builder", "--after", "t1"))
        first = p.file("one")
        second = p.file("two", "build", "builder", "--after", first)
        self.assertIn("would wait on itself", p.err("task", "set", first, "--field", "after=[\"%s\"]" % second))
        self.assertIn("waits on t9", p.err("task", "set", first, "--field", "after=[\"t9\"]"))
        self.assertEqual(p.one()["task"], first)

    def test_next_claim_close_and_done(self):
        p = self.p
        p.file("plan", "plan", "planner", "--brief", "Stage it.")
        p.file("build")
        ins = p.one()
        self.assertEqual((ins["op"], ins["task"], ins["role"], ins["model"], ins["effort"], ins["issued"]),
                         ("task", "t1", "plan", "sonnet", "high", 1))
        claim = p.json("claim", "--json")
        self.assertEqual((claim["task"]["id"], claim["task"]["state"]), ("t1", "running"))
        self.assertEqual(claim["prompt"], "You are the plan.\n")
        self.assertEqual(claim["task"]["brief"], "Stage it.")
        self.assertIn("already claimed", p.err("claim", "t1"))
        p.out("close", "t1", "--outcome", "done", "--result", "staged", "--usage", "12345")
        t1 = p.tasks()["t1"]
        self.assertEqual((t1["state"], t1["outcome"], t1["result"], t1["usage"]), ("closed", "done", "staged", 12345))
        self.assertIn("already closed", p.err("close", "t1", "--outcome", "done"))
        self.assertIn("invalid choice", p.err("close", "t2", "--outcome", "maybe"))
        ins = p.one()
        self.assertEqual((ins["task"], ins["role"], ins["model"], ins["effort"]), ("t2", "build", "opus", "high"))
        plain = p.out("claim")
        self.assertIn("task: t2", plain)
        self.assertIn("files: (unrestricted)", plain)
        self.assertIn("--- prompt ---\nYou are the build.", plain)
        self.assertIn("tasks close t2 --outcome <done|partial|blocked|disputed>", plain)
        p.out("close", "t2", "--outcome", "done")
        self.assertEqual(p.one()["op"], "done")
        self.assertEqual(p.out("next"), "done")
        self.assertEqual([e["task"] for e in p.events("TASKS.TASK.ISSUED")], ["t1", "t2"])
        self.assertEqual([e["task"] for e in p.events("TASKS.TASK.CLOSED")], ["t1", "t2"])

    def test_next_prints_plain_instructions(self):
        p = self.p
        p.file("review", "review", "reviewer", "--key", "s1")
        self.assertEqual(p.out("next"), "run t1 role=review prompt=review agent=reviewer model=opus effort=high key=s1")
        p.out("claim", "t1")
        p.out("close", "t1", "--outcome", "done")
        p.out("file", "--kind", "exec", "--command", "echo hi")
        self.assertEqual(p.out("next"), "exec t2 echo hi")

    def test_next_skips_a_running_task_and_reports_waiting(self):
        p = self.p
        p.file("one")
        p.file("two", "build", "builder", "--after", "t1")
        self.assertEqual(p.one()["task"], "t1")
        p.out("claim")
        waiting = p.one()
        self.assertEqual((waiting["op"], waiting["tasks"]), ("waiting", ["t1", "t2"]))
        self.assertEqual(p.out("next"), "waiting t1 t2")
        self.assertEqual((p.tasks()["t1"]["state"], p.tasks()["t1"]["issued"]), ("running", 1))
        p.out("close", "t1", "--outcome", "done")
        self.assertEqual(p.one()["task"], "t2")

    def test_reissue_once_then_block_and_retry(self):
        p = self.p
        p.file("plan", "plan", "planner")
        self.assertEqual(p.one()["task"], "t1")
        again = p.one()
        self.assertEqual((again["task"], again["issued"]), ("t1", 2))
        self.assertEqual(p.events("TASKS.TASK.REISSUED")[-1]["task"], "t1")
        blocked = p.one()
        self.assertEqual((blocked["op"], blocked["task"]), ("blocked", "t1"))
        self.assertEqual(p.tasks()["t1"]["outcome"], "blocked")
        self.assertEqual(p.events("TASKS.TASK.BLOCKED")[-1]["task"], "t1")
        self.assertEqual(p.one()["op"], "done")
        self.assertEqual(p.json("status", "--json")["retryable"], ["t1"])
        self.assertIn("no task t2", p.err("retry", "t2"))
        p.out("retry", "t1")
        self.assertEqual(p.tasks()["t1"]["issued"], 0)
        reissued = p.one()
        self.assertEqual((reissued["task"], reissued["issued"]), ("t1", 1))
        p.out("claim")
        p.out("close", "t1", "--outcome", "partial", "--result", "half")
        self.assertIn("t1", p.json("status", "--json")["retryable"])
        p.out("retry", "t1")
        p.one()
        p.out("claim")
        p.out("close", "t1", "--outcome", "done")
        self.assertIn("neither running nor closed as one of", p.err("retry", "t1"))

    def test_bare_claim_takes_only_issued_tasks(self):
        p = self.p
        p.file("first")
        p.file("second")
        self.assertIn("no issued task to claim", p.err("claim"))
        self.assertEqual(p.one()["task"], "t1")
        self.assertEqual(p.json("claim", "--json")["task"]["id"], "t1")
        self.assertIn("no issued task to claim", p.err("claim"))
        p.out("close", "t1", "--outcome", "done")
        self.assertEqual(p.one()["task"], "t2")
        self.assertEqual(p.json("claim", "--json")["task"]["id"], "t2")

    def test_claim_by_profile_takes_only_that_profiles_task(self):
        p = self.p
        p.file("lookup", "build", "lookup")
        p.file("build", "build", "builder")
        p.next("--all")
        self.assertIn("no issued task to claim for profile reviewer", p.err("claim", "--agent", "reviewer"))
        self.assertEqual(p.json("claim", "--agent", "builder", "--json")["task"]["id"], "t2")
        self.assertIn("names profile lookup, not builder", p.err("claim", "t1", "--agent", "builder"))
        self.assertEqual(p.json("claim", "--agent", "lookup", "--json")["task"]["id"], "t1")
        self.assertEqual([e["agent"] for e in p.events("TASKS.TASK.CLAIMED")], ["builder", "lookup"])

    def test_next_all_issues_every_ready_task_and_tops_up(self):
        p = self.p
        p.out("file", "--kind", "exec", "--command", "true")
        p.file("review", "review", "reviewer")
        p.file("judge", "judge", "reviewer")
        p.file("fix", "build", "builder", "--after", "t2")
        ins = p.next("--all")
        self.assertEqual([(i["op"], i["task"]) for i in ins], [("exec", "t1"), ("task", "t2"), ("task", "t3")])
        p.out("exec", "t1")
        p.out("claim", "t2")
        p.out("close", "t2", "--outcome", "done")
        ins = p.next("--all")
        self.assertEqual([(i["task"], i["issued"]) for i in ins], [("t3", 2), ("t4", 1)])
        p.out("claim", "t3")
        p.out("claim", "t4")
        p.out("close", "t3", "--outcome", "done")
        p.out("close", "t4", "--outcome", "done")
        self.assertEqual(p.one()["op"], "done")

    def test_next_all_writes_nothing_when_a_profile_is_missing(self):
        p = self.p
        p.file("one")
        p.file("two", "build", "reviewer")
        os.remove(os.path.join(p.root, ".claude", "agents", "reviewer.md"))
        proc = p.run("next", "--all", check=False)
        self.assertEqual(proc.returncode, 2)
        self.assertIn("no agent file at .claude/agents/reviewer.md", proc.stderr)
        self.assertEqual([t["issued"] for t in p.tasks().values()], [0, 0])
        self.assertEqual(p.events("TASKS.TASK.ISSUED"), [])

    def test_next_reads_model_and_effort_from_the_agent_file_at_issue_time(self):
        p = self.p
        p.file("build")
        p.file("build")
        ins = p.one()
        self.assertEqual((ins["agent"], ins["model"], ins["effort"]), ("builder", "opus", "high"))
        p.out("claim", "t1")
        p.out("close", "t1", "--outcome", "done")
        write_agent(p.root, "builder", "sonnet", "low")
        ins = p.one()
        self.assertEqual((ins["model"], ins["effort"]), ("sonnet", "low"))

    def test_exec_runs_the_command_with_the_tracker_unlocked(self):
        p = self.p
        p.out("file", "--kind", "exec", "--command", "echo suites-ok")
        p.out("file", "--kind", "exec", "--command", "echo boom >&2; exit 3")
        p.out("file", "--kind", "exec", "--command",
              "OK_PLANNER_PROJECT_ROOT=%s %s %s item add --pool findings --body from-inside" % (p.root, sys.executable, TASKS))
        ins = p.one()
        self.assertEqual((ins["op"], ins["command"]), ("exec", "echo suites-ok"))
        self.assertIn("suites-ok", p.out("exec", "t1"))
        p.one()
        self.assertIn("exit 3", p.out("exec", "t2"))
        p.one()
        p.out("exec", "t3")
        tasks = p.tasks()
        self.assertEqual((tasks["t1"]["outcome"], tasks["t1"]["result"]), ("done", "suites-ok"))
        self.assertEqual((tasks["t2"]["outcome"], tasks["t2"]["result"]), ("failed", "exit 3: boom"))
        self.assertIn("t2", p.json("status", "--json")["retryable"])
        p.out("retry", "t2")
        self.assertEqual(p.tasks()["t2"]["state"], "open")
        p.one()
        p.out("exec", "t2")
        self.assertEqual(p.items("findings")[0]["body"], "from-inside")
        self.assertIn("already closed", p.err("exec", "t1"))
        p.file("x")
        self.assertIn("not an exec", p.err("exec", "t4"))
        p.out("file", "--kind", "exec", "--command", "printf 'a\\nb\\nc\\n'")
        p.next()
        p.out("exec", "t5", "--tail", "0")
        self.assertEqual(p.tasks()["t5"]["result"], "")
        p.out("file", "--kind", "exec", "--command", "printf 'a\\nb\\nc\\n'")
        p.next()
        p.out("exec", "t6", "--tail", "2")
        self.assertEqual(p.tasks()["t6"]["result"], "b\nc")

    def test_claim_hands_over_consumed_items_by_key_and_state(self):
        p = self.p
        p.out("item", "add", "--pool", "specs", "--key", "s1", "--body", "spec one")
        p.out("item", "add", "--pool", "specs", "--key", "s2", "--body", "spec two")
        p.out("item", "add", "--pool", "specs", "--body", "global spec")
        p.out("item", "add", "--pool", "findings", "--key", "s1", "--body", "open one")
        p.out("item", "add", "--pool", "findings", "--key", "s1", "--body", "fixed one", "--state", "fixed")
        p.file("build", "build", "builder", "--key", "s1", "--consumes", "specs", "findings")
        p.file("review", "review", "reviewer", "--consumes", "specs::s2")
        p.file("audit", "review", "reviewer", "--key", "s1", "--consumes", "findings:*")
        p.file("sweep", "review", "reviewer", "--consumes", "specs:open:*")
        p.one()
        self.assertEqual([i["body"] for i in p.json("claim", "--json")["items"]],
                         ["spec one", "global spec", "open one"])
        p.out("close", "t1", "--outcome", "done")
        p.one()
        self.assertEqual([i["body"] for i in p.json("claim", "--json")["items"]], ["spec two", "global spec"])
        p.out("close", "t2", "--outcome", "done")
        p.one()
        self.assertEqual([i["body"] for i in p.json("claim", "--json")["items"]], ["open one", "fixed one"])
        p.out("close", "t3", "--outcome", "done")
        p.one()
        self.assertEqual([i["body"] for i in p.json("claim", "--json")["items"]],
                         ["spec one", "spec two", "global spec"])

    def test_items_add_list_count_set_and_stdin_body(self):
        p = self.p
        iid = p.out("item", "add", "--pool", "specs", "--key", "s1", "--body", "-", "--producer", "planner",
                    "--field", "file=a.py", "--field", "count=3", stdin="multi\nline\n")
        self.assertEqual(iid, "i1")
        listed = p.items("specs", key="s1")
        self.assertEqual((listed[0]["body"], listed[0]["fields"], listed[0]["producer"]),
                         ("multi\nline\n", {"file": "a.py", "count": 3}, "planner"))
        p.out("item", "add", "--pool", "specs", "--key", "s2", "--body", "two")
        self.assertEqual(len(p.items("specs")), 2)
        self.assertEqual(len(p.items("specs", key="s2")), 1)
        self.assertEqual(p.out("item", "count", "--pool", "specs"), "2")
        self.assertEqual(p.run("item", "count", "--pool", "specs", "--state", "consumed", check=False).returncode, 1)
        p.out("item", "set", "i1", "--state", "consumed", "--note", "done with it", "--field", "extra=1")
        got = p.items("specs", state="consumed")
        self.assertEqual((got[0]["id"], got[0]["note"], got[0]["fields"]["extra"]), ("i1", "done with it", 1))
        self.assertIn("note=done with it", p.out("item", "list", "--pool", "specs"))
        self.assertIn("no item", p.err("item", "set", "i9", "--state", "x"))
        self.assertEqual(p.out("item", "count", "--pool", "specs", "--state", "consumed"), "1")

    def test_item_added_from_a_task_links_back_to_it(self):
        p = self.p
        p.file("review", "review", "reviewer")
        p.one()
        p.out("claim")
        p.out("item", "add", "--pool", "findings", "--body", "bug", "--task", "t1", "--producer", "reviewer")
        p.out("close", "t1", "--outcome", "done")
        self.assertEqual(p.items("findings")[0]["task"], "t1")
        self.assertEqual(p.events("TASKS.ITEM.ADDED")[-1]["task"], "t1")

    def test_close_settles_items_and_accumulates_staged_paths(self):
        p = self.p
        p.out("item", "add", "--pool", "findings", "--body", "one")
        p.out("item", "add", "--pool", "findings", "--body", "two")
        p.file("fix")
        p.one()
        p.out("claim")
        p.out("task", "set", "t1", "--field", "staged=[\"early.py\"]")
        p.out("close", "t1", "--outcome", "done", "--staged", "late.py", "--item", "i1=fixed", "--item", "i2=disputed")
        items = {i["id"]: i for i in p.items("findings")}
        self.assertEqual((items["i1"]["state"], items["i2"]["state"]), ("fixed", "disputed"))
        self.assertEqual(p.tasks()["t1"]["staged"], ["early.py", "late.py"])
        self.assertEqual(p.events("TASKS.TASK.CLOSED")[-1]["items"], ["i1", "i2"])
        p.file("fix")
        p.one()
        self.assertIn("no item i9", p.err("close", "t2", "--outcome", "done", "--item", "i9=fixed"))
        self.assertIn("names no state", p.err("close", "t2", "--outcome", "done", "--item", "i1="))

    def test_triage_marks_repeats_recurrences_and_unfingerprinted(self):
        p = self.p
        p.out("item", "add", "--pool", "findings", "--body", "old refuted", "--fingerprint", "a.py:1", "--state", "refuted")
        p.out("item", "add", "--pool", "findings", "--body", "old fixed", "--fingerprint", "b.py:2", "--state", "fixed")
        p.out("item", "add", "--pool", "findings", "--body", "same again", "--fingerprint", "a.py:1")
        p.out("item", "add", "--pool", "findings", "--body", "came back", "--fingerprint", "b.py:2")
        p.out("item", "add", "--pool", "findings", "--body", "brand new", "--fingerprint", "c.py:3")
        p.out("item", "add", "--pool", "findings", "--body", "no print")
        p.out("item", "triage", "--pool", "findings")
        items = {i["id"]: i for i in p.items("findings")}
        self.assertEqual((items["i3"]["state"], items["i3"]["prior"]), ("repeat", {"id": "i1", "state": "refuted"}))
        self.assertEqual(items["i1"]["repeats"], 1)
        self.assertEqual((items["i4"]["state"], items["i4"]["prior"]), ("recurrence", {"id": "i2", "state": "fixed"}))
        self.assertEqual(items["i5"]["state"], "open")
        self.assertEqual(items["i6"]["state"], "open")
        triaged = p.events("TASKS.ITEM.TRIAGED")[0]
        self.assertEqual((triaged["fresh"], triaged["repeats"], triaged["recurrences"], triaged["unfingerprinted"]),
                         (1, 1, 1, 1))
        p.out("config", "set", "settled_states", '["fixed"]')
        p.out("item", "set", "i4", "--state", "fixed")
        p.out("item", "add", "--pool", "findings", "--body", "third time", "--fingerprint", "b.py:2")
        p.out("item", "triage", "--pool", "findings")
        last = p.items("findings")[-1]
        self.assertEqual((last["state"], last["prior"]), ("repeat", {"id": "i4", "state": "fixed"}))

    def test_batch_groups_open_items_into_tasks(self):
        p = self.p
        for n, (path, body) in enumerate([("a.py", "f1"), ("a.py", "f2"), ("a.py", "f3"), ("b.py", "f4")]):
            p.out("item", "add", "--pool", "findings", "--body", body, "--fingerprint", "%s:%d" % (path, n),
                  "--field", "file=" + path)
        p.out("item", "add", "--pool", "findings", "--body", "no file")
        p.out("item", "add", "--pool", "findings", "--body", "settled", "--state", "refuted")
        p.file("review", "review", "reviewer")
        filed = p.out("batch", "--pool", "findings", "--group-by", "fields.file", "--size", "2", "--after", "t1",
                      "--prompt", "build", "--agent", "builder", "--role", "fix", "--brief", "Fix these.").split("\n")
        self.assertEqual(filed, ["t2", "t3", "t4", "t5"])
        tasks = p.tasks()
        self.assertEqual((tasks["t2"]["files"], tasks["t2"]["batch_items"], tasks["t2"]["after"]), (["a.py"], ["i1", "i2"], ["t1"]))
        self.assertEqual(tasks["t2"]["brief"], "Fix these.\n- i1: f1\n- i2: f2")
        self.assertEqual(tasks["t3"]["batch_items"], ["i3"])
        self.assertEqual((tasks["t4"]["files"], tasks["t4"]["batch_items"]), (["b.py"], ["i4"]))
        self.assertEqual((tasks["t5"].get("files", []), tasks["t5"]["batch_items"]), ([], ["i5"]))
        self.assertEqual({i["id"]: i["state"] for i in p.items("findings")},
                         {"i1": "batched", "i2": "batched", "i3": "batched", "i4": "batched", "i5": "batched",
                          "i6": "refuted"})
        self.assertEqual(p.one()["task"], "t1")
        p.out("claim", "t1")
        p.out("close", "t1", "--outcome", "done")
        p.one()
        claim = p.json("claim", "--json")
        self.assertEqual([i["id"] for i in claim["items"]], ["i1", "i2"])
        p.out("close", "t2", "--outcome", "done", "--item", "i1=fixed", "--item", "i2=disputed")
        architect = p.out("batch", "--pool", "findings", "--state", "disputed", "--prompt", "judge",
                          "--agent", "reviewer", "--role", "architect", "--mark", "ruling")
        self.assertEqual((p.tasks()[architect]["batch_items"], p.items("findings", state="ruling")[0]["id"]),
                         (["i2"], "i2"))
        self.assertEqual(p.out("batch", "--pool", "findings", "--state", "nothing", "--prompt", "build",
                               "--agent", "builder"), "batch: no matching items")
        batched = p.events("TASKS.BATCH.FILED")
        self.assertEqual((batched[0]["tasks"], batched[0]["items"]), (["t2", "t3", "t4", "t5"], ["i1", "i2", "i3", "i4", "i5"]))

    def test_batch_filters_by_key_and_triage_output(self):
        p = self.p
        p.out("item", "add", "--pool", "findings", "--key", "s1", "--body", "was fixed", "--fingerprint", "x:1", "--state", "fixed")
        p.out("item", "add", "--pool", "findings", "--key", "s1", "--body", "back again", "--fingerprint", "x:1")
        p.out("item", "add", "--pool", "findings", "--key", "s1", "--body", "fresh")
        p.out("item", "add", "--pool", "findings", "--key", "s2", "--body", "theirs")
        p.out("item", "triage", "--pool", "findings", "--key", "s1")
        filed = p.out("batch", "--pool", "findings", "--key", "s1", "--state", "recurrence",
                      "--where", "prior.state=fixed", "--prompt", "judge", "--agent", "reviewer")
        self.assertEqual((p.tasks()[filed]["batch_items"], p.tasks()[filed]["key"]), (["i2"], "s1"))
        self.assertEqual({i["id"]: i["state"] for i in p.items("findings")},
                         {"i1": "fixed", "i2": "batched", "i3": "open", "i4": "open"})

    def test_staged_pool_flips_file_items_to_unread_under_the_tasks_key(self):
        p = self.p
        p.out("config", "set", "staged_pool", "files")
        p.out("item", "add", "--pool", "files", "--key", "s1", "--fingerprint", "a.py", "--body", "a.py", "--state", "read")
        p.file("fix", "build", "builder", "--key", "s1")
        p.file("review", "review", "reviewer", "--key", "s1", "--consumes", "files:unread")
        p.file("other", "review", "reviewer", "--key", "s2", "--consumes", "files:unread")
        p.one()
        p.out("claim")
        p.out("close", "t1", "--outcome", "done", "--staged", "a.py", "b.py")
        files = {(i["fingerprint"], i["key"]): i["state"] for i in p.items("files")}
        self.assertEqual(files, {("a.py", "s1"): "unread", ("b.py", "s1"): "unread"})
        p.one()
        self.assertEqual(sorted(i["fingerprint"] for i in p.json("claim", "--json")["items"]), ["a.py", "b.py"])
        p.out("close", "t2", "--outcome", "done", "--item", "i1=read", "--item", "i2=read")
        p.one()
        self.assertEqual(p.json("claim", "--json")["items"], [])

    def test_refile_copies_a_task_and_links_it(self):
        p = self.p
        p.out("item", "add", "--pool", "specs", "--key", "s1", "--body", "spec")
        src = p.file("build", "build", "builder", "--key", "s1", "--brief", "Build s1", "--files", "a.py",
                     "--consumes", "specs", "--cites", "story:x")
        p.one()
        p.out("claim")
        p.out("close", src, "--outcome", "done")
        review = p.file("review", "review", "reviewer", "--key", "s1")
        again = p.out("refile", src, "--after", review)
        t = p.tasks()[again]
        self.assertEqual((t["previous"], t["after"], t["brief"], t["files"], t["key"], t["cites"], t["consumes"]),
                         (src, [review], "Build s1", ["a.py"], "s1", ["story:x"], [{"pool": "specs", "state": "open"}]))
        self.assertEqual(p.events("TASKS.TASK.FILED")[-1]["previous"], src)
        rebrief = p.out("refile", src, "--brief", "Fix the finding")
        self.assertEqual(p.tasks()[rebrief]["brief"], "Fix the finding")

    def test_task_set_guards_tracker_fields(self):
        p = self.p
        p.file("build", "build", "builder", "--key", "s1")
        p.one()
        p.out("task", "set", "t1", "--usage", "161000", "--field", "note=big")
        t = p.tasks()["t1"]
        self.assertEqual((t["usage"], t["note"]), (161000, "big"))
        for reserved in ("t", "id", "state", "kind", "issued"):
            self.assertIn("belongs to the tracker", p.err("task", "set", "t1", "--field", "%s=x" % reserved))
        self.assertIn("no task t9", p.err("task", "set", "t9", "--usage", "1"))

    def test_status_reports_usage_and_filters_by_key(self):
        p = self.p
        p.file("build", "build", "builder", "--key", "s1")
        p.file("review", "review", "reviewer", "--key", "s2")
        p.one()
        p.out("claim")
        p.out("close", "t1", "--outcome", "done", "--usage", "100")
        p.out("task", "set", "t2", "--usage", "50")
        status = p.json("status", "--json")
        self.assertEqual((status["usage"], [t["id"] for t in status["open_tasks"]]), (150, ["t2"]))
        self.assertEqual(p.json("status", "--key", "s1", "--json")["usage"], 100)
        plain = p.out("status")
        self.assertIn("usage: 150", plain)
        self.assertIn("open t2 task review key=s2 state=open issued=0 after=-", plain)

    def test_rounds_mark_what_a_round_filed_closed_and_staged(self):
        p = self.p
        p.file("early")
        self.assertEqual(p.json("round", "show", "--json"),
                         {"round": None, "filed": [], "closed": [], "open": [], "staged": [], "items": [], "usage": 0})
        p.out("round", "start")
        self.assertEqual(p.json("status", "--json")["run"]["round"], "round-1")
        p.file("fix")
        p.out("item", "add", "--pool", "findings", "--body", "in round")
        p.next("--all")
        p.out("claim", "t1")
        p.out("claim", "t2")
        p.out("close", "t1", "--outcome", "done", "--staged", "old.py")
        p.out("close", "t2", "--outcome", "done", "--staged", "x.py", "y.py", "--usage", "7")
        self.assertEqual(p.json("round", "show", "--json"),
                         {"round": "round-1", "filed": ["t2"], "closed": ["t2"], "open": [],
                          "staged": ["x.py", "y.py"], "items": ["i1"], "usage": 7})
        p.out("round", "start", "verify")
        self.assertEqual(p.json("round", "show", "--json")["staged"], [])
        self.assertIn("staged: -", p.out("round", "show"))
        self.assertEqual((p.tasks()["t1"]["round"], p.tasks()["t2"]["round"]), (None, "round-1"))
        self.assertEqual([(e["name"], e["number"]) for e in p.events("TASKS.ROUND.STARTED")],
                         [("round-1", 1), ("verify", 2)])

    def test_report_renders_tasks_and_pools(self):
        p = self.p
        p.file("build")
        p.one()
        p.out("claim")
        p.out("item", "add", "--pool", "findings", "--body", "a | b", "--task", "t1", "--producer", "reviewer")
        p.out("close", "t1", "--outcome", "done", "--result", "built", "--staged", "x.py", "--usage", "9")
        report = p.out("report")
        rows = [l for l in report.split("\n") if l.startswith("| t1 ")]
        self.assertEqual(len(rows), 1)
        cells = [c.strip() for c in rows[0].strip("|").split("|")]
        self.assertEqual(cells, ["t1", "task", "build", "", "", "closed", "done", "1", "9", "built"])
        rows = [l for l in report.split("\n") if l.startswith("| i1 ")]
        cells = [c.strip() for c in rows[0].strip("|").split("|")]
        self.assertEqual(cells, ["i1", "", "open", "", "reviewer", "t1", "0", "a / b"])

    def test_snapshot_keeps_a_backup_and_rebuild_recovers(self):
        p = self.p
        p.file("plan", "plan", "planner")
        p.file("build")
        p.one()
        p.out("claim")
        p.out("close", "t1", "--outcome", "done")
        jsonl = os.path.join(p.root, ".ok-planner", "tasks", "run.jsonl")
        before = open(jsonl).read()
        status_before = p.json("status", "--json")
        p.out("snapshot")
        after = open(jsonl).read()
        self.assertLess(len(after.split("\n")), len(before.split("\n")))
        backups = [f for f in os.listdir(os.path.join(p.root, ".ok-planner", ".cache")) if f.endswith(".pre-snapshot.jsonl")]
        self.assertEqual(len(backups), 1)
        self.assertEqual(open(os.path.join(p.root, ".ok-planner", ".cache", backups[0])).read(), before)
        self.assertEqual(p.json("status", "--json"), status_before)
        shutil.rmtree(os.path.join(p.root, ".ok-planner", ".cache"))
        p.out("use", ".ok-planner/tasks/run.jsonl")
        p.out("rebuild")
        self.assertEqual(p.json("status", "--json"), status_before)
        self.assertEqual((p.one()["task"], p.tasks()["t2"]["role"]), ("t2", "build"))
        copy = os.path.join(p.root, "copy.jsonl")
        p.out("snapshot", "--out", copy)
        records = sum(len(p.records(t)) for t in ("run", "agent", "prompt", "task", "item", "event"))
        self.assertEqual(len([l for l in open(copy).read().split("\n") if l.strip()]), records)

    def test_index_extends_incrementally_and_recovers_from_a_truncated_log(self):
        p = self.p
        p.file("one")
        jsonl = os.path.join(p.root, ".ok-planner", "tasks", "run.jsonl")
        with open(jsonl, "a") as f:
            f.write(json.dumps({"t": "item", "id": "i1", "pool": "specs", "key": None, "state": "open",
                                "body": "appended by hand"}) + "\n")
        self.assertEqual(p.items("specs")[0]["body"], "appended by hand")
        p.out("item", "set", "i1", "--field", "late=1")
        self.assertEqual(p.items("specs")[0]["fields"], {"late": 1})
        lines = open(jsonl).read().split("\n")
        with open(jsonl, "w") as f:
            f.write("\n".join(lines[:-3]) + "\n")
        self.assertEqual(p.items("specs"), [])
        self.assertEqual(list(p.tasks()), ["t1"])

    def test_nothing_is_written_beside_the_run_file(self):
        p = self.p
        p.file("one")
        p.one()
        self.assertEqual(sorted(os.listdir(os.path.join(p.root, ".ok-planner", "tasks"))), ["run.jsonl"])
        cache = sorted(os.listdir(os.path.join(p.root, ".ok-planner", ".cache")))
        self.assertIn(".gitignore", cache)
        self.assertIn("current", cache)
        self.assertTrue(any(f.endswith(".lock") for f in cache))
        self.assertTrue(any(f.endswith(".sqlite") for f in cache))

    def test_explicit_file_flag_and_env_override_the_pointer(self):
        p = self.p
        other = os.path.join(p.root, "other.jsonl")
        p.out("init", "other", "--file", other)
        p.out("use", ".ok-planner/tasks/run.jsonl")
        self.assertEqual(p.json("--file", other, "status", "--json")["run"]["name"], "other")
        proc = p.run("status", "--json", env={"OK_TASKS": other})
        self.assertEqual(json.loads(proc.stdout)["run"]["name"], "other")

    def test_no_estate_and_no_run_fail_plainly(self):
        bare = tempfile.mkdtemp(prefix="ok-tasks-bare-")
        try:
            env = dict(os.environ)
            env.pop("OK_PLANNER_PROJECT_ROOT", None)
            proc = subprocess.run([sys.executable, TASKS, "next"], cwd=bare, env=env, capture_output=True, text=True)
            self.assertEqual(proc.returncode, 2)
            self.assertIn("no project estate", proc.stderr)
            self.assertEqual(os.listdir(bare), [])
            os.makedirs(os.path.join(bare, ".ok-planner"))
            proc = subprocess.run([sys.executable, TASKS, "next"], cwd=bare, env=env, capture_output=True, text=True)
            self.assertIn("no run selected", proc.stderr)
        finally:
            shutil.rmtree(bare, ignore_errors=True)

    def test_help_without_a_verb(self):
        proc = self.p.run(check=False)
        self.assertEqual(proc.returncode, 1)
        self.assertIn("usage: tasks", proc.stdout)


    def test_concurrent_claims_take_distinct_tasks(self):
        p = self.p
        for _ in range(4):
            p.file("build")
        p.next("--all")
        env = dict(os.environ, OK_PLANNER_PROJECT_ROOT=p.root)
        procs = [subprocess.Popen([sys.executable, TASKS, "claim", "--agent", "builder", "--json"], cwd=p.root,
                                  env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
                 for _ in range(4)]
        outs = [proc.communicate(timeout=60)[0] for proc in procs]
        self.assertTrue(all(proc.returncode == 0 for proc in procs))
        claimed = sorted(json.loads(o)["task"]["id"] for o in outs)
        self.assertEqual(claimed, ["t1", "t2", "t3", "t4"])
        self.assertEqual({t["state"] for t in p.tasks().values()}, {"running"})

    def test_claim_leaves_the_task_open_when_the_prompt_file_is_missing(self):
        p = self.p
        p.file("build")
        p.one()
        os.remove(os.path.join(p.root, ".ok-planner", "prompts", "build.md"))
        self.assertIn("missing file", p.err("claim"))
        self.assertEqual(p.tasks()["t1"]["state"], "open")

    def test_claim_warns_when_the_prompt_changed_since_registration(self):
        p = self.p
        p.file("build")
        p.one()
        with open(os.path.join(p.root, ".ok-planner", "prompts", "build.md"), "a") as f:
            f.write("more\n")
        proc = p.run("claim", "--json")
        self.assertIn("changed on disk", proc.stderr)
        self.assertEqual(json.loads(proc.stdout)["prompt"], "You are the build.\nmore\n")

    def test_claim_refuses_an_exec_and_an_unissued_task(self):
        p = self.p
        p.out("file", "--kind", "exec", "--command", "true")
        p.file("build")
        p.next("--all")
        self.assertEqual(p.json("claim", "--json")["task"]["id"], "t2")
        self.assertIn("is an exec", p.err("claim", "t1"))
        p.file("later")
        self.assertIn("has not been issued", p.err("claim", "t3"))

    def test_retry_releases_a_running_task(self):
        p = self.p
        p.file("build")
        p.one()
        p.out("claim")
        self.assertEqual(p.out("retry", "t1"), "released t1")
        t = p.tasks()["t1"]
        self.assertEqual((t["state"], t["issued"], t["claimed"]), ("open", 0, None))
        self.assertEqual(p.events("TASKS.TASK.RELEASED")[-1]["task"], "t1")
        self.assertEqual(p.one()["task"], "t1")

    def test_claim_hint_names_the_invoked_script(self):
        p = self.p
        p.file("build")
        p.one()
        self.assertIn("%s close t1" % os.path.realpath(TASKS), p.out("claim"))

    def test_triage_with_key_ignores_other_keys_priors(self):
        p = self.p
        p.out("item", "add", "--pool", "findings", "--key", "s1", "--body", "settled elsewhere", "--fingerprint", "a:1", "--state", "refuted")
        p.out("item", "add", "--pool", "findings", "--key", "s2", "--body", "fresh here", "--fingerprint", "a:1")
        p.out("item", "triage", "--pool", "findings", "--key", "s2")
        self.assertEqual(p.items("findings", key="s2")[0]["state"], "open")
        p.out("item", "triage", "--pool", "findings")
        self.assertEqual(p.items("findings", key="s2")[0]["state"], "repeat")

    def test_verbs_without_a_subcommand_print_usage(self):
        for verb in ("agent", "prompt", "registry", "config", "item", "task", "round"):
            proc = self.p.run(verb, check=False)
            self.assertEqual(proc.returncode, 2, verb)
            self.assertIn("usage: tasks %s" % verb, proc.stderr)
        self.assertIn("invalid int value", self.p.err("batch", "--pool", "x", "--size", "x", "--prompt", "build",
                                                       "--agent", "builder"))

    def test_partial_last_line_is_dropped_and_the_log_stays_well_formed(self):
        p = self.p
        p.file("one")
        jsonl = os.path.join(p.root, ".ok-planner", "tasks", "run.jsonl")
        with open(jsonl, "a") as f:
            f.write('{"t": "item", "id": "i1", "pool": "specs", "sta')
        self.assertEqual(p.items("specs"), [])
        self.assertEqual(list(p.tasks()), ["t1"])
        p.out("item", "add", "--pool", "specs", "--body", "after the crash")
        for line in open(jsonl).read().split("\n"):
            if line.strip():
                json.loads(line)
        self.assertEqual([i["body"] for i in p.items("specs")], ["after the crash"])

    def test_same_size_rewrite_of_the_log_is_detected(self):
        p = self.p
        p.out("item", "add", "--pool", "specs", "--body", "aaaa")
        jsonl = os.path.join(p.root, ".ok-planner", "tasks", "run.jsonl")
        text = open(jsonl).read()
        with open(jsonl, "w") as f:
            f.write(text.replace('"body": "aaaa"', '"body": "bbbb"'))
        self.assertEqual(p.items("specs")[0]["body"], "bbbb")

    def test_relative_file_paths_resolve_against_the_root(self):
        p = self.p
        p.out("init", "other", "--file", "other.jsonl")
        p.out("use", ".ok-planner/tasks/run.jsonl")
        sub = os.path.join(p.root, "deep", "er")
        os.makedirs(sub)
        env = dict(os.environ, OK_PLANNER_PROJECT_ROOT=p.root)
        proc = subprocess.run([sys.executable, TASKS, "--file", "other.jsonl", "status", "--json"], cwd=sub, env=env,
                              capture_output=True, text=True)
        self.assertEqual(json.loads(proc.stdout)["run"]["name"], "other")
        proc = subprocess.run([sys.executable, TASKS, "status", "--json"], cwd=sub,
                              env=dict(env, OK_TASKS="other.jsonl"), capture_output=True, text=True)
        self.assertEqual(json.loads(proc.stdout)["run"]["name"], "other")
        stems = {f.rsplit(".", 1)[0] for f in os.listdir(os.path.join(p.root, ".ok-planner", ".cache")) if f.startswith("tasks-")}
        self.assertEqual(len(stems), 2)


class ConvergeTests(unittest.TestCase):
    def test_converge_vendors_the_profiles_the_tracker_reads(self):
        consumer = tempfile.mkdtemp(prefix="ok-tasks-consumer-")
        try:
            subprocess.run(["git", "init", "-q", "."], cwd=consumer, check=True)
            write_agent(consumer, "ok-opus", "haiku", "low")
            first = subprocess.run(["bash", CONVERGE], cwd=consumer, check=True, capture_output=True, text=True).stdout
            self.assertIn("COLLISION (ok-planner): .claude/agents/ok-opus.md", first)
            self.assertIn("model: haiku", open(os.path.join(consumer, ".claude", "agents", "ok-opus.md")).read())
            diagnose = subprocess.run(["bash", CONVERGE, "diagnose"], cwd=consumer, capture_output=True, text=True).stdout
            self.assertIn("collision: .claude/agents/ok-opus.md", diagnose)
            os.remove(os.path.join(consumer, ".claude", "agents", "ok-opus.md"))
            subprocess.run(["bash", CONVERGE], cwd=consumer, check=True, capture_output=True, text=True)
            for name in ("ok-opus", "ok-sonnet", "ok-haiku"):
                path = os.path.join(consumer, ".claude", "agents", name + ".md")
                self.assertTrue(os.path.isfile(path), name)
                text = open(path).read()
                self.assertIn("Materialized by ok-planner v", text)
                self.assertIn("tasks claim --agent %s" % name, text)
            tracker = os.path.join(consumer, ".ok-planner", "bin", "tasks")
            self.assertTrue(os.access(tracker, os.X_OK))
            env = dict(os.environ, OK_PLANNER_PROJECT_ROOT=consumer)

            def tasks(*args):
                return subprocess.run([sys.executable, tracker] + list(args), cwd=consumer, env=env, check=True,
                                      capture_output=True, text=True).stdout.strip()
            tasks("init", "demo")
            for name in ("ok-opus", "ok-sonnet", "ok-haiku"):
                tasks("agent", "register", name)
            agents = {json.loads(l)["id"]: json.loads(l) for l in tasks("dump", "--type", "agent").split("\n")}
            self.assertEqual({n: (a["model"], a["effort"]) for n, a in agents.items()},
                             {"ok-opus": ("opus", "high"), "ok-sonnet": ("sonnet", "high"), "ok-haiku": ("haiku", "low")})
            for name in agents:
                self.assertIn("disallowedTools: Agent", open(os.path.join(consumer, ".claude", "agents", name + ".md")).read())
            license_text = open(os.path.join(consumer, ".claude", "agents", "LICENSE")).read()
            self.assertIn("ok-*.md profiles", license_text)
            self.assertIn("Apache License", license_text)
            diagnose = subprocess.run(["bash", CONVERGE, "diagnose"], cwd=consumer, capture_output=True, text=True).stdout
            self.assertFalse([l for l in diagnose.split("\n") if l.startswith("DRIFT") and "agents" in l])
        finally:
            shutil.rmtree(consumer, ignore_errors=True)


if __name__ == "__main__":
    unittest.main(verbosity=1)
