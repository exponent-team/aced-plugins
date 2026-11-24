# Aced plugins

Aced's interview-prep plugins for Claude and ChatGPT.

| Plugin | Folder | Marketplace file |
|---|---|---|
| Aced for Claude | [`plugins/claude`](plugins/claude) | `.claude-plugin/marketplace.json` |
| Aced for ChatGPT (and Codex) | [`plugins/chatgpt`](plugins/chatgpt) | `.agents/plugins/marketplace.json` |

## Layout

```
.claude-plugin/marketplace.json     Claude marketplace → plugins/claude
.agents/plugins/marketplace.json    OpenAI marketplace → plugins/chatgpt
plugins/
  claude/                           Claude plugin (.claude-plugin/plugin.json, .mcp.json)
  chatgpt/                          ChatGPT plugin (plugin.json, mcp.json)
shared/
  skills/                           skills used by both plugins (source of truth)
scripts/sync-shared.sh              copies shared/skills into each plugin
```

## Shared vs. platform-specific skills

Both platforms install a plugin by copying its folder, so a plugin can't reference files
outside it. Shared skills therefore live in `shared/skills/` and get copied into each
plugin's `skills/` folder:

- **Shared skill:** edit it in `shared/skills/<name>/`, then run `scripts/sync-shared.sh`
  and commit the copies too. Never edit the copies inside `plugins/`; CI fails if they
  differ from `shared/`.
- **Platform-specific skill:** put it directly in `plugins/claude/skills/<name>/` or
  `plugins/chatgpt/skills/<name>/`. Don't reuse a shared skill's name, or the sync will
  overwrite it.

Shared skills should avoid naming a specific assistant. When a step differs by platform,
say so inline, for example "If you're running in Claude Code, …".
