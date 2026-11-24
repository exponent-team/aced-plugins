# Aced plugins

Aced's interview-prep plugin for Claude, ChatGPT and Codex. One plugin folder serves every
platform, and both marketplaces install it straight from `main`, so merging publishes.

```
.claude-plugin/marketplace.json     Claude marketplace
.agents/plugins/marketplace.json    ChatGPT/Codex marketplace
plugin/                             the plugin
  .claude-plugin/                   Claude only: manifest, with the MCP server inline
  .codex-plugin/                    ChatGPT/Codex only: manifest and mcp.json
  skills/                           shared: every platform loads these
  assets/                           shared: icons
```

Anything only one platform should read goes in that platform's dot-folder, and its manifest
points to it. Don't add files with names a platform loads automatically, such as `.mcp.json`,
`hooks/hooks.json`, `agents/` or `commands/`, at the top of `plugin/`: every platform that knows
the name would load them.

Each platform reads only its own manifest, so a change to the plugin's name, description or MCP
URL goes in both. Skills are shared: they shouldn't name a specific assistant, and when a step
differs by platform they say so inline, for example "If you're running in Claude Code, …".

## Local development

To try the plugin in Claude Code from this checkout:

```sh
scripts/dev.sh           # Aced MCP at http://localhost:3000/api/mcp (run `npm run dev` in exponent)
scripts/dev.sh --prod    # production MCP, for skill-only changes
ACED_MCP_URL=https://<tunnel>/api/mcp scripts/dev.sh
```

The skills are symlinked, so after editing a `SKILL.md` just restart the session. Use `/mcp` in
the session to sign in to Aced. Pull requests run `claude plugin validate` on the plugin and
the marketplace.
