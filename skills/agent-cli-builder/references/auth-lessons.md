# Auth lessons from `tgbot` (Telegram user-account login)

Real failures, in the order users hit them. Each became a code change and a documentation line.

1. **No terminal in the agent shell.** Interactive prompts fail. Fix: a non-interactive two-step form and a clear "needs a terminal" message that names the alternative.
2. **Silent hang on a filtered network.** The TCP connect succeeded but the protocol stream was dropped, and the client library retried forever. Fix: per-transport connect timeout, fallback transport, proxy flag, one final error listing what was tried.
3. **"code sent" but nothing arrives.** The service answered "deliver to an already logged-in app", with no fallback, and sometimes delivers nothing to third-party clients. The tool only said `code_sent: true`. Fix: print delivery type, fallback and wait time; add `--resend`; recommend QR when there is no fallback. The request itself matched what other libraries send, so retrying cannot help.
4. **The agent cannot show a QR.** A QR refreshing every 30 s needs a person looking at a screen. Fix: the human logs in on their own computer, `session export` there, `login --import` where the agent runs; `--qr-file` writes the QR as an image for headless hosts.
5. **Secrets in chat.** People offered to paste api hashes and codes to the agent. Fix: document env files with `chmod 600`, keep the login human-only, and say so in the skill.
6. **Session revoked when used from two places.** Fix: cross-process file lock, one-place rule after export, `logout --local` on the source.
7. **QR file alone did not work.** A flag that implies a mode must be applied before the options struct is built; test each flag combination without a terminal. `--qr-file` now implies `--qr`.
8. **The QR expires while it travels.** Expired QR scans open a download page, which looks like a bug. Fix: write the image atomically, put `expires_at` in a sidecar file, print the expiry, tell the agent to send it right after a refresh.
9. **A step can succeed on the server and stall in the client.** The QR scan was accepted but the 2FA password was missing, so the process waited silently and `status` said "not authorized" while the Devices list showed a session. Fix: warn about the password before the scan, print "scan accepted, waiting for password", persist an `awaiting_2fa` state, make the rerun resume without a new scan, and add `login --reset` for unfinished logins.
10. **Lock queues look like hangs.** A status call waited 90 s behind a running login. Fix: the long-running command writes a marker; others fail at once with "login in progress".
11. **Stale binaries.** Docs mention flags the installed build lacks. Fix: `--version` with the VCS revision and a rebuild hint on "unknown flag".
12. **Skill contradictions.** "Never log in yourself" clashed with an owner who has only a phone. Write the owner-with-phone / headless-agent scenario as numbered steps and keep the rule "secrets never go through chat, the human confirms privileged switches".

General rule: when an external service decides whether a step works, the tool must report what the service said, not what the tool hoped.
