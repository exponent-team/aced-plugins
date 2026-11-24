# Aced for Claude

Prep for interviews with [Aced](https://www.aced.io) inside Claude. The plugin connects
Claude to Aced's interview data: real questions that candidates reported, verified interview
experiences, expert-written company guides, and courses. Every answer links back to its
source on Aced, so you know you're practicing with real questions.

## What it does

| Skill | Use it when |
|---|---|
| `prep-from-jd` | You have a job description. Paste it in, or paste the posting URL, and get a study plan for that company and role, built from Aced data with every source linked. |

## Install

In Claude Code:

```
/plugin install aced --marketplace exponent-team/aced-plugins
```

In claude.ai or Cowork, go to **Customize > Plugins > Add > Add marketplace** and enter
`exponent-team/aced-plugins`.

## Connecting

The plugin adds the Aced connector (`https://www.aced.io/api/mcp`). You can search and read
free content without signing in. Members-only lessons, guides and interview reports ask you
to sign in to Aced, and they unlock with an active Aced membership.

## Try it

> Here's the JD for a job I'm interviewing for: [paste]. Help me prep.
