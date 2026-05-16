# woo-ki-cc

[![Version](https://img.shields.io/badge/version-0.1.0-blue)](CHANGELOG.md) [![License](https://img.shields.io/badge/license-Apache--2.0-green)](LICENSE)

Claude-Code-Starterkit fuer IT-Leute, die strukturiert mit KI arbeiten wollen.

## Was ist das?

Ein schlankes Template, das deine Claude-Code-Session direkt brauchbar macht — auch mit dem **Free-Plan**. Kein Pro, kein Opus, kein 1M-Context vorausgesetzt.

Zwei Schichten:

| Schicht | Datei | Was sie tut |
|---------|-------|-------------|
| **Reflexe** | `CLAUDE.md` | Vier Haltungs-Regeln (denken vor coden, simpel halten, chirurgisch aendern, ans Ziel arbeiten) |
| **Workflow** | `CLAUDE.md` + `context.md` + `notizen/` | Sieben Session-Prinzipien (Uebergabe, Beifang, Aufgaben, Fehler, Staunen, Ursachensuche, Audit) |

Claude liest `CLAUDE.md` beim Start automatisch und fuehrt sich entsprechend.

## Schnellstart

1. **Claude Code installieren** — Anleitung: https://docs.claude.com/claude-code (Free-Plan reicht zum Anfangen)
2. **Diesen Ordner in dein Projekt kopieren** (oder als Template-Repo klonen)
3. **Im Projektordner `claude` starten** — die Reflexe + Workflows sind sofort aktiv
4. **Erste Session beenden** mit `#h` — Claude schreibt eine Uebergabe in `context.md`
5. **Naechste Session starten** mit `#w` — Claude knuepft an

## Position in der woo-ki-Familie

| Repo | Wer? | Was? |
|------|------|------|
| **woo-ki-starter** | Tool-agnostisch (Kilo/Cursor/Windsurf/CC) | 5 Workflow-Prinzipien, AGENTS.md |
| **woo-ki-cc** (hier) | Claude-Code-fokussiert, Free-tauglich | 4 Reflexe + 7 Workflows + CC-Mechanik |

## Inhalt

```
CLAUDE.md                ← Reflexe + Workflows (wird automatisch gelesen)
context.md               ← Session-Uebergabe (Claude pflegt das)
notizen/                 ← Beifang, Fehler, Staunen (chronologisch)
docs/anleitung.md        ← Lange Form: jedes Prinzip mit Beispielen
examples/                ← Statusline-Script, settings.json
hooks/                   ← Optionale Mechanik (UserPromptSubmit, Guards)
```

Zwei Statusline-Varianten:
- `examples/statusline.sh` — minimal: Modell + Context-Prozent.
- `examples/statusline-full.sh` — reich: zusaetzlich 5h- und 7d-Rate-Limit mit Burn-Rate-Pfeil und Reset-Zeit.

Beide nutzen ausschliesslich offiziell dokumentierte stdin-Felder. Keine API-Calls, kein OAuth-Token, keine Reverse-Engineering-Tricks.

Statusline, Hooks und settings.json sind **optional**. Du wirst nicht erschlagen — pickst was du brauchst. Die Anleitung sagt, was wofuer gut ist.

## Free vs Pro — kurz

Claude Code mit dem **Free-Plan** funktioniert. Du hast weniger Tokens pro Stunde und kein Opus, dafuer einen kleineren Context. Die **Statusline** aus `examples/` zeigt dir Context-Auslastung und Limit-Verbrauch live — wichtig, weil du das Limit sonst erst merkst, wenn es schon weg ist.

Pro: hoehere Limits, Sonnet ohne Sorge, Opus optional. Setup ist identisch.

## Herkunft

Gewachsen aus der taeglichen Arbeit von Stephan Waldtmann (https://waldtmann.de) mit Claude Code. Die vier Reflexe gehen auf Andrej Karpathys oeffentliche Beobachtungen zu LLM-Coding-Fallen (Januar 2026) zurueck, die Forrest Chang in seinem viralen `andrej-karpathy-skills`-Repo (https://github.com/forrestchang/andrej-karpathy-skills) in eine CLAUDE.md geformt hat — wir haben sie hier neu formuliert und mit den Workflows aus `woo-ki-starter` zusammen gefuehrt.

## Mitmachen

Pull Requests willkommen — siehe `CONTRIBUTING.md`. Versionen werden in `CHANGELOG.md` festgehalten. Wer mitgeschrieben hat, steht in `AUTHORS.md` — inkl. der KI-Modelle, die beim Formulieren geholfen haben.

## Lizenz

Apache 2.0 — siehe `LICENSE`. Nimm, was du brauchst.
