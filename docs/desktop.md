# woo-ki-cc — Anleitung Desktop-App (Mac / Windows)

> **Status:** Stub. Wird ergänzt, sobald die Schritte mit echter Desktop-App verifiziert sind. PR willkommen (siehe `CONTRIBUTING.md`).

## Worum es geht

Die Desktop-App ist ein eigenständiges Fenster — keine Terminal-CLI, kein IDE. Sie kann lokale Dateien lesen (anders als die Web-App), aber wie genau `CLAUDE.md` und Hooks angebunden werden, hängt von der App-Version ab.

## Wo werden die Inhalte abgelegt

_TODO: konkrete Pfade ergänzen._

Wahrscheinliche Stellen:

- **Projekt-Anbindung** — Ordner im UI auswählen, `CLAUDE.md` wird daraus gelesen.
- **App-weite Custom Instructions** — falls vorhanden, für Reflexe die immer gelten.

## Was funktioniert, was nicht

Funktioniert (vermutlich):

- Die vier **Reflexe** und die sieben **Workflows** aus `CLAUDE.md`.
- Lokale **`context.md`** und **`notizen/`**, sobald der Projekt-Ordner angebunden ist.
- **`settings.json`** Permissions — meist gleich wie CLI.

Unsicher / prüfen:

- **Statusline** — die Desktop-App hat eine eigene Statuszeile. Ob das `statusLine`-Konfig aus `settings.json` greift, klär mit der App-Doku.
- **Hooks** — die Desktop-App kann lokale Shell-Hooks oft ausführen, weil sie auf dem Rechner läuft. Hooks `PreToolUse`/`PostToolUse`/`UserPromptSubmit` testen, bevor du dich auf sie verlässt.

## Workflow-Vorschlag für die Desktop-App

1. Projekt-Ordner anbinden (`~/projekte/mein-projekt`).
2. `CLAUDE.md` + `context.md` + `notizen/` liegen darin — App liest mit.
3. Falls Hooks unterstützt: `~/.claude/hooks/` einrichten wie in der CLI-Anleitung.
4. Ansonsten: Reflexe + Workflows reichen schon weit.

## Was du beitragen kannst

Wenn du die Desktop-App nutzt: PR oder Issue mit konkreten Klick-Pfaden und Stand-Datum.
