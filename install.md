# Install Aced

These are setup steps for an AI agent. Aced (aced.io) is an interview prep platform: real
interview questions, verified candidate reports, expert guides and coaches. Setup adds two
things: the Aced connector (an MCP server) and the `prep` skill.

Only do what these steps describe. Before you change a config file, tell the user which file
and what you're adding, and ask them to confirm.

## If your app supports plugins, use the plugin instead

The plugin installs both parts and keeps them up to date.

- **Claude Code:** `/plugin marketplace add exponent-team/aced-plugins`, then `/plugin install aced@aced-plugins`
- **Codex:** `codex plugin marketplace add exponent-team/aced-plugins`, then install Aced from the plugin directory
- **claude.ai, Claude Desktop, Cowork:** the user adds `exponent-team/aced-plugins` under Customize › Plugins › Add marketplace

Stop here if one of these worked.

## 1. Add the Aced connector

A remote MCP server over streamable HTTP. No API key: free content works without signing in.

- **Name:** `aced`
- **URL:** `https://www.aced.io/api/mcp`

Add it the way your app configures MCP servers. Common ones:

- **Cursor** (`~/.cursor/mcp.json`): `{"mcpServers": {"aced": {"url": "https://www.aced.io/api/mcp"}}}`
- **VS Code** (`.vscode/mcp.json`): `{"servers": {"aced": {"type": "http", "url": "https://www.aced.io/api/mcp"}}}`
- **Gemini CLI** (`~/.gemini/settings.json`): `{"mcpServers": {"aced": {"httpUrl": "https://www.aced.io/api/mcp"}}}`

Merge into the existing file; don't overwrite other servers.

## 2. Add the prep skill

Download the skill from:

`https://raw.githubusercontent.com/exponent-team/aced-plugins/main/plugin/skills/prep/SKILL.md`

Save it unchanged as `prep/SKILL.md` wherever your app keeps skills. If your app has no
skills, save it in its rules or instructions folder and follow it when the user wants to
prepare for an interview at a specific company or pastes a job description.

## 3. Check it works

Restart or reload MCP servers if your app needs it, then confirm the `aced` tools are listed:
`search`, `fetch`, `interview_overview`, `list_questions`, `list_coaches` and `list_jobs`.

## 4. Tell the user

Say what you installed and where, then suggest a first prompt:

> Here's the JD for a job I'm interviewing for: [paste]. Help me prep.

Members-only guides, lessons and interview reports ask the user to sign in to Aced the first
time they're opened. Everything else works without an account.

## Updating

The connector updates itself. To update the skill, download the same URL again and replace
the saved `prep/SKILL.md`. Do this when the user asks to update Aced.
