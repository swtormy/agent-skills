---
name: send-dev-diagrams
description: >-
  Renders architecture and process flows as styled Mermaid PNGs and sends them
  to the user's Telegram. Use whenever planning, developing, iterating,
  explaining, or finishing a slice so the user can see the system visually.
  Triggers: схема, архитектура, план, доработка, реализация, как устроено,
  send to telegram, visually.
---

# Send dev diagrams

The user reads a **diagram in Telegram** faster than a wall of chat. Do not replace a flow with a table in the reply.

Field-tested while planning a Windows job-search service: card-poster HTML failed; a Mermaid flowchart with yes/no branches worked.

## When to send

Send when this turn created or changed a **flow or system shape** (plan, architecture, new contour, "how it works now").

Skip: typo, one selector, "ok", read-only exploration with no new picture.

Usually **1–2 PNGs** per turn. Caption: one or two lines, user's language.

## Format

Mermaid `flowchart` only (same pattern as Anthropic docs). Not an HTML card poster. Not Anthropic `canvas-design` (art, not engineering).

Node and edge style: [references/mermaid-style.md](references/mermaid-style.md).

Prefer a process (`flowchart TD` with decisions) over a star of arrows from one box. Two diagrams if needed: process and containers.

Quote labels, especially non-ASCII: `A(["Reboot host"])`.

## Draw and send

1. Write a `.mmd` file in a temp dir (not git).
2. Render (config next to this skill):

```bash
npx --yes @mermaid-js/mermaid-cli@11.4.2 -i flow.mmd -o flow.png -b white -s 2 -c mermaid-config.json
```

On Windows PowerShell, point `-c` at this skill's `mermaid-config.json`.

3. Send. Never print tokens.

Credentials, first match wins:

- env `TELEGRAM_BOT_TOKEN` + `TELEGRAM_CHAT_ID`
- or `BOT_TOKEN` + `CHAT_ID`
- or a `KEY=value` file in `TELEGRAM_ENV`

```powershell
powershell -NoProfile -File scripts/send-png.ps1 -Path flow.png -Caption "one-line caption"
```

4. In the agent chat: one sentence that Telegram got the image. Do not paste an ASCII copy of the graph.

## Do not

- Put tokens, chat ids, or session strings in chat, git, or the caption
- Invent a bot token
- Commit or push unless the user asked
