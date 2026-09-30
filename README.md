# woo-ki-cc

[![Version](https://img.shields.io/badge/version-0.1.1-blue)](CHANGELOG.md) [![License](https://img.shields.io/badge/license-Apache--2.0-green)](LICENSE)

Claude-Code-Starterkit für IT-Leute, die strukturiert mit KI arbeiten wollen.

## Was ist das?

Ein schlankes Template für Claude-Code-Sessions — läuft auch mit dem **Free-Plan**. Kein Pro, kein Opus, kein 1M-Context vorausgesetzt.

Zwei Schichten:

| Schicht | Datei | Was sie tut |
|---------|-------|-------------|
| **Reflexe** | `CLAUDE.md` | Vier Haltungs-Regeln (denken vor coden, simpel halten, chirurgisch ändern, ans Ziel arbeiten) |
| **Workflow** | `CLAUDE.md` + `context.md` + `notizen/` | Sieben Session-Prinzipien (Übergabe, Beifang, Aufgaben, Fehler, Staunen, Ursachensuche, Audit) |

Claude liest `CLAUDE.md` beim Start automatisch und führt sich entsprechend.

## Schnellstart

1. **Claude Code installieren** — Anleitung: https://docs.claude.com/claude-code (Free-Plan reicht zum Anfangen)
2. **Diesen Ordner in dein Projekt kopieren** (oder als Template-Repo klonen)
3. **Im Projektordner `claude` starten** — die Reflexe + Workflows sind sofort aktiv
4. **Erste Session beenden** mit `#h` — Claude schreibt eine Übergabe in `context.md`
5. **Nächste Session starten** mit `#w` — Claude knüpft an

## Position in der woo-ki-Familie

| Repo | Wer? | Was? |
|------|------|------|
| [**woo-ki-starter**](https://git.authbox.de/stephan/woo-ki-starter) | Tool-agnostisch (Kilo/Cursor/Windsurf/CC) | 5 Workflow-Prinzipien, AGENTS.md |
| **woo-ki-cc** (hier) | Claude-Code-fokussiert, Free-tauglich | 4 Reflexe + 7 Workflows + CC-Mechanik |

## Inhalt

```
CLAUDE.md                ← Reflexe + Workflows (wird automatisch gelesen)
context.md               ← Session-Übergabe (Claude pflegt das)
notizen/                 ← Beifang, Fehler, Staunen (chronologisch)
docs/anleitung.md        ← Lange Form: jedes Prinzip mit Beispielen
examples/                ← Statusline-Script, settings.json
hooks/                   ← Optionale Mechanik (UserPromptSubmit, Guards)
```

Zwei Statusline-Varianten:
- `examples/statusline.sh` — minimal: Modell + Context-Prozent.
- `examples/statusline-full.sh` — reich: zusätzlich 5h- und 7d-Rate-Limit mit Burn-Rate-Pfeil und Reset-Zeit.

Statusline, Hooks und settings.json sind **optional**. Die Anleitung sagt, was wofür gut ist.

## Herkunft

Gewachsen aus der täglichen Arbeit von Stephan Waldtmann (https://waldtmann.de) mit Claude Code. Die vier Reflexe gehen auf Andrej Karpathys öffentliche Beobachtungen zu LLM-Coding-Fallen (Januar 2026) zurück, die Forrest Chang in seinem viralen `andrej-karpathy-skills`-Repo (https://github.com/forrestchang/andrej-karpathy-skills) in eine CLAUDE.md geformt hat — wir haben sie hier neu formuliert und mit den Workflows aus [`woo-ki-starter`](https://git.authbox.de/stephan/woo-ki-starter) zusammengeführt.

## Mitmachen

Pull Requests willkommen — siehe `CONTRIBUTING.md`. Versionen werden in `CHANGELOG.md` festgehalten. Wer mitgeschrieben hat, steht in `AUTHORS.md` — inkl. der KI-Modelle, die beim Formulieren geholfen haben.

## Lizenz

Apache 2.0 — siehe `LICENSE`. Nimm, was du brauchst.
