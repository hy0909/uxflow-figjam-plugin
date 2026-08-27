#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export PATH="/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export CLAUDE_MODEL="${CLAUDE_MODEL:-claude-fable-5}"

cd "$SCRIPT_DIR"
exec node server.js
