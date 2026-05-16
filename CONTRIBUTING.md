# Beitragen zu woo-ki-cc

Pull Requests, Issues und Diskussion sind willkommen. Repo lebt auf Codeberg.

## Was ist erwuenscht

- **Klarere Erklaerungen** in `CLAUDE.md` / `docs/anleitung.md`. Wenn du als Einsteiger an einer Stelle haengen geblieben bist, schreib einen PR oder ein Issue mit der Stelle und deinem Vorschlag.
- **Sauberere Beispiele** in `examples/` und `hooks/`. Wenn du eines davon getestet hast und Verbesserungen findest: gerne.
- **Plattform-Hinweise.** Die Beispiele sind macOS-getestet. Linux-Hinweise (insbesondere `date -d` statt `date -j -f`) als Kommentar oder zweite Variante sind sehr willkommen.
- **Weitere kleine Hook-Beispiele**, wenn sie wirklich nuetzlich und sicher sind (keine "blind eval", keine Curl-Pipes).

## Was wir nicht aufnehmen

- Code, der API-Tokens, OAuth-Tokens oder nicht-dokumentierte Endpoints anzapft.
- "Mega-Frameworks". Das Repo bleibt schlank — sechs Dateien, klare Reflexe, klare Workflows. Wenn dein Beitrag eine eigene Welt aufmacht, gehoert er in dein eigenes Repo.
- Generierte Boilerplate ohne erkennbaren Mehrwert.

## Wie

1. **Issue oeffnen** mit dem, was du aendern willst. Kurz reicht. Wenn unsicher: erst Issue, dann PR.
2. **Fork** + Branch (`feature/<kurz>` oder `fix/<kurz>`).
3. **PR** gegen `main`. Klein halten — ein Thema pro PR.
4. **Tests/Smoke:** Wenn du ein Script aenderst, beschreibe im PR kurz, wie du es getestet hast.

## Commit-Konvention

Klassisch:

```
<typ>: <kurze beschreibung>

<optional: laengere erklaerung>
```

Typen: `feat`, `fix`, `docs`, `chore`, `refactor`, `examples`, `hooks`.

Wenn dein Commit ueberwiegend mit einem KI-Modell entstanden ist, haeng einen `Co-Authored-By:`-Trailer an, der das Modell namentlich nennt — Beispiel:

```
docs: Reflex 4 (Ziel statt Schritte) klarer formuliert

Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>
```

Das ist keine Pflicht, aber wir machen es. Transparenz darueber, wer die Worte gesetzt hat, ist Teil der Sache.

## Versionierung

Wir folgen [SemVer](https://semver.org/) mit Pre-1.0-Pragmatismus:

- **0.x.0** — Inhalte werden geschaerft, kleinere Brueche moeglich.
- **1.0.0** — Reflexe + Workflows stabilisiert, klare Update-Pfade.
- Aenderungen werden in `CHANGELOG.md` festgehalten ([Keep a Changelog](https://keepachangelog.com)).

## Code of Conduct

Sei respektvoll. Keine Diskriminierung. Wenn du dich unsicher fuehlst oder ein Problem mit jemandem hast, melde dich bei Stephan (Kontakt siehe `AUTHORS.md`).

## Lizenz

Beitraege werden unter Apache 2.0 lizenziert — siehe `LICENSE`.
