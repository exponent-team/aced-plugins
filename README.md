# Aced plugins

Aced's interview-prep plugins for Claude and ChatGPT.

```
.claude-plugin/marketplace.json     Claude marketplace
.agents/plugins/marketplace.json    ChatGPT/Codex marketplace
plugins/claude/                     Claude plugin + Claude-only skills
plugins/chatgpt/                    ChatGPT plugin + ChatGPT-only skills
shared/skills/                      skills used by both plugins
```

## How publishing works

Work on `main`. On every push to `main`, the **Build** GitHub Action copies
`shared/skills/` into each plugin's `skills/` folder and force-pushes the result to the
`build` branch. Both marketplaces install their plugin from `build`, so merging to `main`
publishes. Never commit to `build` by hand.

- **Skill for both platforms:** add it to `shared/skills/<name>/`.
- **Skill for one platform:** add it to `plugins/<platform>/skills/<name>/`. Use a name
  that isn't in `shared/skills/`, or the shared skill overwrites it.

Shared skills shouldn't name a specific assistant. When a step differs by platform, say so
inline, for example "If you're running in Claude Code, …".
