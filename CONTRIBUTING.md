# woo-ki-cc — Beitragen

Pull Requests, Issues und Diskussion sind willkommen. Repo lebt auf Codeberg.

## Was ist erwünscht

- **Klarere Erklärungen** in `CLAUDE.md` / `docs/anleitung.md`. Wenn du als Einsteiger an einer Stelle hängen geblieben bist, schreib einen PR oder ein Issue mit der Stelle und deinem Vorschlag.
- **Sauberere Beispiele** in `examples/` und `hooks/`. Wenn du eines davon getestet hast und Verbesserungen findest: gerne.
- **Plattform-Hinweise.** Die Beispiele sind macOS-getestet. Linux-Hinweise (insbesondere `date -d` statt `date -j -f`) als Kommentar oder zweite Variante sind willkommen.
- **Weitere kleine Hook-Beispiele**, wenn sie wirklich nützlich und sicher sind (keine "blind eval", keine Curl-Pipes).

## Was wir nicht aufnehmen

- Code, der API-Tokens, OAuth-Tokens oder nicht-dokumentierte Endpoints anzapft.
- "Mega-Frameworks". Wenn dein Beitrag eine eigene Welt aufmacht, gehört er in dein eigenes Repo.
- Generierte Boilerplate ohne erkennbaren Mehrwert.

## Wie

1. **Issue öffnen** mit dem, was du ändern willst. Kurz reicht. Wenn unsicher: erst Issue, dann PR.
2. **Fork** + Branch (`feature/<kurz>` oder `fix/<kurz>`).
3. **PR** gegen `main`. Klein halten — ein Thema pro PR.
4. **Tests/Smoke:** Wenn du ein Script änderst, beschreibe im PR kurz, wie du es getestet hast.

## Commit-Konvention

Klassisch:

```
<typ>: <kurze beschreibung>

<optional: längere erklärung>
```

Typen: `feat`, `fix`, `docs`, `chore`, `refactor`, `examples`, `hooks`.

Wenn dein Commit überwiegend mit einem KI-Modell entstanden ist, häng einen `Co-Authored-By:`-Trailer an, der das Modell namentlich nennt — Beispiel:

```
docs: Reflex 4 (Ziel statt Schritte) klarer formuliert

Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>
```

## Versionierung

Wir folgen [SemVer](https://semver.org/) mit Pre-1.0-Pragmatismus:

- **0.x.0** — Inhalte werden geschärft, kleinere Brüche möglich.
- **1.0.0** — Reflexe + Workflows stabilisiert, klare Update-Pfade.
- Änderungen werden in `CHANGELOG.md` festgehalten ([Keep a Changelog](https://keepachangelog.com)).

## Code of Conduct

Sei respektvoll. Keine Diskriminierung. Wenn du dich unsicher fühlst oder ein Problem mit jemandem hast, melde dich bei Stephan (Kontakt siehe `AUTHORS.md`).

## Lizenz

Beiträge werden unter Apache 2.0 lizenziert — siehe `LICENSE`.
