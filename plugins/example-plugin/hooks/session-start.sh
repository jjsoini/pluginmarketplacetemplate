#!/usr/bin/env bash
# Example SessionStart hook for the example-plugin.
#
# Hooks receive JSON on stdin and can emit JSON on stdout to influence the
# session. This example simply injects a short note into the session context.
#
# See: https://docs.claude.com/en/docs/claude-code/hooks

set -euo pipefail

cat <<'JSON'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "example-plugin is installed. Run /hello to confirm it works."
  }
}
JSON
