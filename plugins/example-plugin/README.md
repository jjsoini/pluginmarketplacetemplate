# example-plugin

A reference plugin that demonstrates every component type a Claude Code plugin can ship. Copy this directory to start a new plugin, then strip out the parts you don't need.

## Layout

```
example-plugin/
├── .claude-plugin/
│   └── plugin.json          # Required. Plugin manifest (name, version, etc.)
├── commands/
│   └── hello.md             # Slash command → /hello
├── agents/
│   └── example-reviewer.md  # Subagent available to the Agent tool
├── skills/
│   └── example-skill/
│       └── SKILL.md         # Auto-loaded skill (model decides when)
├── hooks/
│   ├── hooks.json           # Hook configuration
│   └── session-start.sh     # Script invoked by the hook
└── .mcp.json                # MCP servers bundled with the plugin
```

Only `.claude-plugin/plugin.json` is required. Every other directory is optional — delete what you don't use. Claude Code auto-discovers `commands/`, `agents/`, and `skills/` by convention.

## Component reference

| Component | Where | Triggered by |
|-----------|-------|--------------|
| Command   | `commands/*.md`            | User types `/hello` |
| Agent     | `agents/*.md`              | Delegated via the Agent tool |
| Skill     | `skills/<name>/SKILL.md`   | Model loads it when relevant |
| Hook      | `hooks/hooks.json`         | A lifecycle event (e.g. SessionStart) |
| MCP       | `.mcp.json`                | Tools exposed once the plugin is enabled |

## Path variable

Inside hooks and MCP configs, use `${CLAUDE_PLUGIN_ROOT}` to reference files relative to the plugin root. It expands to this plugin's absolute install path, so the plugin works regardless of where it's checked out.
