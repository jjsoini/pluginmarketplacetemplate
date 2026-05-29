# Team Plugin Marketplace

An internal [Claude Code plugin marketplace](https://docs.claude.com/en/docs/claude-code/plugins) for the team. A marketplace is just a git repository with a `.claude-plugin/marketplace.json` file that lists one or more plugins. Once added, teammates can browse and install any plugin in this repo.

## Repository layout

```
myplugins/
├── .claude-plugin/
│   └── marketplace.json     # The marketplace manifest — lists all plugins
├── plugins/
│   └── example-plugin/      # One directory per plugin
│       ├── .claude-plugin/
│       │   └── plugin.json   # Required plugin manifest
│       ├── commands/         # Slash commands
│       ├── agents/           # Subagents
│       ├── skills/           # Skills
│       ├── hooks/            # Lifecycle hooks
│       └── .mcp.json         # Bundled MCP servers
└── README.md
```

## Using this marketplace

Add the marketplace once (point at this repo on GitHub, or a local path while developing):

```
/plugin marketplace add your-org/myplugins
```

Then install a plugin from it:

```
/plugin install example-plugin@team-marketplace
```

Browse and manage everything interactively with:

```
/plugin
```

To develop locally without pushing to GitHub, add the marketplace by absolute path:

```
/plugin marketplace add /Users/jussisoini/dev/claude-training/myplugins
```

After editing a plugin, refresh the marketplace to pick up changes:

```
/plugin marketplace update team-marketplace
```

## Adding a new plugin

1. Copy `plugins/example-plugin` to `plugins/<your-plugin>`.
2. Edit `plugins/<your-plugin>/.claude-plugin/plugin.json` (set `name`, `description`, `version`).
3. Delete the component directories you don't need — only `plugin.json` is required.
4. Register it by adding an entry to the `plugins` array in `.claude-plugin/marketplace.json`:

   ```json
   {
     "name": "your-plugin",
     "source": "./plugins/your-plugin",
     "description": "What it does.",
     "version": "0.1.0"
   }
   ```

5. Reload with `/plugin marketplace update team-marketplace` and test.

See `plugins/example-plugin/README.md` for details on each component type.

## Validating

Both manifests are JSON. A quick sanity check before committing:

```sh
cat .claude-plugin/marketplace.json | python3 -m json.tool > /dev/null && echo "marketplace.json OK"
cat plugins/example-plugin/.claude-plugin/plugin.json | python3 -m json.tool > /dev/null && echo "plugin.json OK"
```
