# agent-skills

Public skills for AI coding agents (Claude Code, Cursor, Codex, Grok). Each skill is a folder in `skills/` with a `SKILL.md`.

| Skill | What it does |
|---|---|
| [agent-cli-builder](skills/agent-cli-builder/SKILL.md) | Design and build a CLI that gives agents safe access to a service, instead of an MCP server. Output format, exit codes, safety model, auth that survives real use, docs, tests. Distilled from [tgbot-cli](https://github.com/swtormy/tgbot-cli). |

## Install

Copy the skill folder into your agent's skills directory.

```bash
git clone https://github.com/swtormy/agent-skills
cp -r agent-skills/skills/agent-cli-builder ~/.claude/skills/        # Claude Code, all projects
cp -r agent-skills/skills/agent-cli-builder .claude/skills/          # one project
cp -r agent-skills/skills/agent-cli-builder .cursor/skills/          # Cursor, one project
```

Then ask your agent, for example: "make a CLI for the Acme API so you can use it".

## Contributing

One folder per skill, `SKILL.md` first, supporting files under `references/`. Keep skills short and concrete, and based on something that was actually built and field-tested. No secrets or personal data.

## License

MIT
