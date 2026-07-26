#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUT="$( curl -sS -X POST -H 'Content-Type: application/json' \
    --data "${BODY:-}" \
    "http://127.0.0.1:8080/v1/items" )"
NAME='it'\''s fine'
TAB=$'\t'
COUNT=$(( 1 << 2 ))
STRIPPED="${SCRIPT_DIR#/}"
cat <<EOF
unbalanced " quote and 'half-open inside heredoc
EOF
cat <<-'DONE'
	more "unbalanced ' content
DONE
echo "${OUT}${NAME}${TAB}${COUNT}${STRIPPED}" \
  | grep -v '#not-a-comment' || true
