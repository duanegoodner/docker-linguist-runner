#!/bin/bash
# run-linguist.sh

UID=$(id -u)
GID=$(id -g)
TOOL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker compose --project-directory "$TOOL_DIR" \
  run --rm linguist "$@"
