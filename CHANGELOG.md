# Changelog

Alle nennenswerten Aenderungen werden hier festgehalten. Format folgt [Keep a Changelog](https://keepachangelog.com), Versionierung folgt [SemVer](https://semver.org/).

## [Unreleased]

## [0.1.0] — 2026-05-16

### Hinzugefuegt

- `CLAUDE.md` mit zwei Schichten: vier Reflexe (Denken vor Tun / Einfach halten / Chirurgisch aendern / Ziel statt Schritte) und sieben Workflows (`#h`/`#w`/`#bei`/`#todo`/`#oops`/`#ahh`/`#rca`/`#audit`).
- `context.md` als Vorlage fuer Session-Uebergaben.
- `examples/statusline.sh` (minimal) und `examples/statusline-full.sh` (mit Rate-Limit + Burn-Rate) — beide TOS-konform via offiziellem stdin-Schema.
- `examples/settings.json` als kommentiertes Starter-Setup.
- `hooks/block-dangerous-bash.sh` (PreToolUse, Bash-Blacklist) und `hooks/inject-date.sh` (UserPromptSubmit, Datum als Kontext).
- `AUTHORS.md`, `CONTRIBUTING.md`, `LICENSE` (Apache 2.0), `.gitignore`.

### Inspiration

- Vier Reflexe nach Andrej Karpathys Beobachtungen zu LLM-Coding-Fallen (Jan 2026), in Anlehnung an Forrest Changs viralen Entwurf `forrestchang/andrej-karpathy-skills` (https://github.com/forrestchang/andrej-karpathy-skills).
- Fuenf Workflows aus `woo-ki-starter` (tool-agnostisches Geschwister-Repo).
