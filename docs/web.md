# Anleitung — Claude Web-App (claude.ai/code)

> **Status:** Stub. Anleitung wird ergaenzt, sobald die Schritte mit echtem Account verifiziert sind. Wenn du Erfahrungen hast: PR willkommen (siehe `CONTRIBUTING.md`).

## Worum es geht

Die Web-App auf https://claude.ai/code hat **kein lokales Dateisystem**. Du kannst hier keine `CLAUDE.md` in ein Projekt legen, keine Hooks ausfuehren, keine `settings.json` setzen. Stattdessen traegst du die *Inhalte* von `CLAUDE.md` an die richtige Stelle der Web-Oberflaeche ein, sodass Claude sie bei jeder Konversation kennt.

## Wo werden die Inhalte abgelegt

_TODO: konkrete UI-Pfade ergaenzen — Stand 2026-05 ist die Anthropic-Oberflaeche im Wandel._

Wahrscheinliche Stellen:

- **Projects** → ein neues Projekt anlegen, in den **Project Knowledge / Project Instructions** den Inhalt von `CLAUDE.md` einfuegen.
- **Custom Instructions** (Account-weit) — fuer Reflexe, die in jedem Chat gelten sollen.

## Was funktioniert, was nicht

Funktioniert:

- Die vier **Reflexe** (Denken vor Tun / Einfach halten / Chirurgisch aendern / Ziel statt Schritte).
- Die sieben **Workflows** als Tags (`#h`, `#w`, `#bei`, `#todo`, `#oops`, `#ahh`, `#rca`, `#audit`) — sie sind reine Konventionen und kosten Claude nichts.
- **`context.md` und `notizen/`** als manuell gepflegte Dateien im Projekt (Upload als Project Files).

Funktioniert nicht:

- **Statusline** — gibt es im Web nicht.
- **Hooks** — kein lokales Filesystem, keine Shell.
- **`settings.json` Permissions** — UI-seitig anders geregelt.

## Workflow-Vorschlag fuer die Web-App

1. Im Projekt: `CLAUDE.md`-Inhalt in die Project Instructions.
2. `context.md` als Project File hochladen — bei jeder neuen Session lesen lassen.
3. Beifang / Oops / Staunen als Markdown-Notizen lokal pflegen, in das Projekt hochladen wenn Claude darauf zugreifen soll.
4. Vor jedem Audit: alle `notizen/*.md` hochladen, `#audit` triggern.

Etwas aufwaendiger als CLI/IDE, aber die Reflexe und Workflows wirken.

## Was du beitragen kannst

Wenn du die Web-App nutzt: PR oder Issue mit konkreten Klick-Pfaden (mit Datum, weil sich die UI aendert).
