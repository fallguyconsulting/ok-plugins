#!/usr/bin/env bash
set -euo pipefail

OUT="$( curl -sS -H 'Content-Type: application/json' \
    --data '{}' \
    "http://127.0.0.1:8080/v1/items" )"

# @constraint: a retired-tag comment after quote-heavy lines must still be seen.
echo "${OUT}"
