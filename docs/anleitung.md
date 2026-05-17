# woo-ki-cc — Anleitung

Hier ist die lange Form. Wenn du nur loslegen willst: `README.md` reicht. Wenn du verstehen willst, *warum* es so ist und *wie* du es an dein Setup anpasst: lies hier weiter.

## Inhalt

- [Wo läuft Claude Code](#wo-läuft-claude-code)
- [Vorbereitung](#vorbereitung)
- [Schritt 1 — Claude Code installieren](#schritt-1--claude-code-installieren)
- [Schritt 2 — `CLAUDE.md` in dein Projekt](#schritt-2--claudemd-in-dein-projekt)
- [Schritt 3 — Erste Session](#schritt-3--erste-session)
- [Schritt 4 — Shell-Alias für den Projektstart](#schritt-4--shell-alias-für-den-projektstart)
- [Die vier Reflexe — was sie wirklich bewirken](#die-vier-reflexe--was-sie-wirklich-bewirken)
- [Die sieben Workflows — wie du sie nutzt](#die-sieben-workflows--wie-du-sie-nutzt)
- [Statusline einrichten](#statusline-einrichten)
- [Hooks einrichten](#hooks-einrichten)
- [`settings.json` anpassen](#settingsjson-anpassen)
- [Permission-Modi — Vorsicht beim Komfort](#permission-modi--vorsicht-beim-komfort)
- [Weiter rein: Skills, Subagents, MCP](#weiter-rein-skills-subagents-mcp)
- [Free vs Pro — was sich praktisch unterscheidet](#free-vs-pro--was-sich-praktisch-unterscheidet)

---

## Wo läuft Claude Code

Claude Code ist nicht an eine einzelne Oberfläche gebunden. Du hast die Wahl:

| Variante | Wer es nutzt |
|----------|--------------|
| **CLI im Terminal** — `claude` aufrufen | Wer ohnehin im Terminal lebt. Schnell, leichtgewichtig, kommt mit `tmux`/`screen` klar — beides ist aber **nicht erforderlich**. |
| **VS Code Extension** | Wahrscheinlich der bequemste Einstieg für IT-Leute, die nicht ausschließlich CLI arbeiten. Code-Diffs visuell, Hover, Navigation. |
| **JetBrains Extension** | IntelliJ, PyCharm, GoLand, WebStorm usw. — analog zur VS-Code-Variante. |
| **Desktop-App** (Mac/Windows) | Eigenständiges Fenster. Gut, wenn du Claude losgelöst vom Editor laufen lassen willst. Eigene Anleitung: [`desktop.md`](desktop.md) (Stub, PR willkommen). |
| **Web-App** auf https://claude.ai/code | Ohne Installation, Browser reicht. Praktisch unterwegs oder auf fremden Geräten. Eigene Anleitung: [`web.md`](web.md) (Stub, PR willkommen). |

**Alle Varianten lesen `CLAUDE.md` aus dem Projektordner** — die Reflexe und Workflows wirken in jeder gleich. Hooks und Statusline funktionieren primär in CLI und Desktop-App; in den IDE-Extensions teils begrenzt (siehe deren Doku).

Empfehlung für den Anfang: VS Code Extension *oder* CLI. Wahl ist Geschmackssache.

### Was vom Repo wo greift

Nicht jedes Feature dieses Repos läuft in jeder Variante. Stand 2026-05 — prüf die jeweilige Claude-Code-Doku, wenn du dir unsicher bist:

| Feature | CLI | VS Code | JetBrains | Desktop | Web (claude.ai/code) |
|---------|:---:|:-------:|:---------:|:-------:|:--------------------:|
| `CLAUDE.md` Auto-Load | ja | ja | ja | ja | ja (per Projekt-Anbindung) |
| `context.md` + `notizen/` | ja | ja | ja | ja | ja |
| Tags (`#h`, `#w`, ...) | ja | ja | ja | ja | ja (reine Konvention, kein Tool) |
| Statusline | **ja** | nein (IDE hat eigene Status-Bar) | nein | unklar | nein |
| Hooks (`PreToolUse` etc.) | **ja** | wahrscheinlich ja | wahrscheinlich ja | wahrscheinlich ja | nein (kein lokales Filesystem) |
| `settings.json` Permissions | ja | ja | ja | ja | begrenzt |

**Reflexe + Workflows** in `CLAUDE.md` wirken **überall**. Die Mechanik-Schicht (Statusline + Hooks + Permission-Allow/Deny) lebt vor allem in CLI und Desktop; in IDE-Extensions teilweise, im Web kaum.

Praktischer Tipp: VS Code + CLI parallel — IDE zum Coden und Diff-Lesen, CLI wenn du Hooks oder die Statusline brauchst.

## Vorbereitung

Du brauchst:

- Ein Terminal (Bash oder Zsh).
- `git` (kommt auf macOS und Linux meist mit, auf Windows: WSL oder Git for Windows).
- `jq` für die Statusline und manche Hooks (`brew install jq` auf macOS, `apt install jq` auf Debian/Ubuntu).
- Einen Anthropic-Account — kostenloses Konto reicht zum Anfangen.

## Schritt 1 — Claude Code installieren

Anthropic dokumentiert die Installation hier: https://docs.claude.com/claude-code

Die zwei häufigsten Wege:

```bash
# Per npm (cross-platform)
npm install -g @anthropic-ai/claude-code

# Per Homebrew (macOS / Linux mit brew)
brew install claude-code
```

Danach in einem Terminal `claude` aufrufen. Beim ersten Start fragt Claude nach deinem Account und einer Login-Methode (Browser-Login mit dem Anthropic-Konto ist der einfachste Weg).

## Schritt 2 — `CLAUDE.md` in dein Projekt

Klon dir dieses Repo, oder kopier dir die Dateien einzeln rüber:

```bash
cd ~/projekte/mein-projekt
git clone https://codeberg.org/StephanWaldtmann/woo-ki-cc tmp-woo-ki-cc
cp tmp-woo-ki-cc/CLAUDE.md .
cp tmp-woo-ki-cc/context.md .
mkdir -p notizen
rm -rf tmp-woo-ki-cc
```

Claude Code liest `CLAUDE.md` beim Start automatisch — du musst nichts weiter konfigurieren.

## Schritt 3 — Erste Session

Im Projektordner:

```bash
claude
```

Sag etwa: "Lies CLAUDE.md und gib mir eine Kurzfassung der Regeln, an die du dich halten wirst." Wenn die Antwort die vier Reflexe und die sieben Workflows enthält, ist alles eingerichtet.

Beende die Session mit `#h` — Claude schreibt eine Übergabe in `context.md`. Nächste Session: `claude` starten, `#w` sagen, weiter geht's.

---

## Schritt 4 — Shell-Alias für den Projektstart

Damit `CLAUDE.md` wirkt, muss Claude Code **im Projekt-Ordner** gestartet werden — sonst liest es die Datei nicht. Wenn du das täglich tust und manuell `cd` und `claude` tippst, vergisst du es manchmal und arbeitest ohne — dann fehlen Reflexe + Workflows still, ohne dass es jemand meldet.

Bau dir einen Alias. Datei je nach Shell:

| Shell | Datei |
|-------|-------|
| Zsh (macOS-Default seit Catalina) | `~/.zshrc` |
| Bash (Linux-Default) | `~/.bashrc` (manchmal `~/.bash_profile`) |

Eintrag (Beispiel — pass den Pfad an):

```bash
# Mein Projekt: immer aus dem richtigen Ordner starten
projekt() {
    cd ~/projekte/mein-projekt && claude "$@"
}
```

Funktion statt einfachem `alias`, weil eine Funktion Argumente weiterleiten kann (`projekt --continue` etwa).

Datei neu laden (oder Terminal neu starten):

```bash
source ~/.zshrc    # oder ~/.bashrc
```

Ab jetzt: `projekt` getippt — du landest im Ordner, Claude startet, `CLAUDE.md` greift. Für mehrere Projekte einfach mehrere Funktionen:

```bash
api()   { cd ~/projekte/api   && claude "$@"; }
shop()  { cd ~/projekte/shop  && claude "$@"; }
notes() { cd ~/projekte/notes && claude "$@"; }
```

### Warum nicht einfach im Home-Verzeichnis starten?

Du kannst `claude` auch aus `~` starten. Dann liest Claude aber `~/CLAUDE.md` (wenn vorhanden) oder gar nichts Projekt-Spezifisches. Die Reflexe und Workflows aus diesem Repo greifen erst, wenn Claude die `CLAUDE.md` *deines Projekts* findet — und das tut es zuverlässig nur, wenn das Arbeitsverzeichnis stimmt.

### `Bash`-Subshells in Hooks

Hooks und Bash-Befehle, die Claude während der Session aufruft, laufen in **Subshells ohne deine `.zshrc`/`.bashrc`**. Wenn du dort Aliase oder PATH-Einträge definierst und ein Hook die braucht — funktioniert nicht. Lösungen:

- PATH explizit im Hook setzen (`export PATH="/opt/homebrew/bin:$PATH"` o.ä.).
- Tools mit vollem Pfad aufrufen (`/usr/local/bin/jq` statt `jq`).
- Alias durch Funktion ersetzen und Funktion auch direkt im Hook-Script definieren.

Wer eine Stunde sucht "warum läuft mein Hook im Terminal aber nicht in der Session", landet meistens hier.

---

## Die vier Reflexe — was sie wirklich bewirken

### Reflex 1 — Denken vor Tun

Ein häufiges Verhalten von KI-Agenten: sie machen einfach. Du sagst "behebe den Fehler", und die KI fixt nicht den Fehler, sondern eine Annahme, die nebenbei getroffen wurde.

Reflex 1 zwingt Annahmen explizit zu machen. Wenn du etwa "die Aufgabe ist nicht klar" sagst und Claude das anders versteht als du, soll Claude *nachfragen*, nicht raten.

**Beispiel:** Du sagst "mach die Tabelle schneller". Claude könnte annehmen: "schneller" = bessere Render-Performance. Tatsächlich meinst du: "schneller fertig", also der Server soll die JSON-Antwort früher liefern. Mit Reflex 1 fragt Claude: "Meinst du Frontend-Render oder Backend-Antwortzeit?" Spart die Falsch-Iteration.

### Reflex 2 — Einfach halten

KI hat eine Tendenz, "vorsorglich" Code zu schreiben — Helper-Funktionen, Abstraktionen, Konfig-Flags für Features, die nie kommen.

Reflex 2 bremst das. Drei ähnliche Zeilen sind besser als ein verfrühter Helper. Eine Funktion erst extrahieren, wenn sie wirklich woanders gebraucht wird.

### Reflex 3 — Chirurgisch ändern

KI sieht beim Bugfix oft auch "Verbesserungspotenzial" — und packt Refactoring, Umbenennung und Stil-Updates in dieselbe Änderung. Das macht PRs schwer lesbar.

Reflex 3 sagt: was die Aufgabe nicht erfordert, rührst du nicht an. Bugfix heißt Bugfix. Wenn du nebenbei eine schlechte Stelle siehst — sag es als Hinweis, nicht als zusätzliche Änderung im selben Commit.

### Reflex 4 — Ziel statt Schritte

Wenn du Claude einen Plan vorgibst, wird der Plan stur ausgeführt — auch dann, wenn er falsch ist.

Reflex 4 dreht das um. Du sagst: "am Ende soll Test X grün sein" oder "die Funktion soll JSON zurückgeben mit Feldern A/B/C". Claude wählt den Weg. Wenn der Weg besser ist als der, den du dir vorgestellt hast: gut. Wenn nicht: du siehst sofort, dass das Ziel nicht erreicht wurde.

Praktischer Tipp: bei `#todo` formulier die Aufgabe so, dass *die Prüfung* drinsteht. "Login muss mit Email/Passwort funktionieren und auf 'Falsch' eine Fehlermeldung zeigen" ist besser als "Login-Form bauen".

---

## Die sieben Workflows — wie du sie nutzt

### `#h` — Übergabe schreiben

Am Ende einer Session: tippe `#h`. Claude liest, was passiert ist, und schreibt eine kompakte Zusammenfassung in `context.md`:

- Was haben wir gemacht?
- Was ist offen?
- Was ist der nächste Schritt?

Tipp: lies die Übergabe kurz durch. Wenn sie etwas weglässt, was dir wichtig ist, korrigier eine Zeile. `context.md` ist das Gedächtnis — nimm es ernst.

### `#w` — Wiederaufnahme

Nächste Session, `claude` starten, `#w` tippen. Claude liest `context.md` und knüpft an. Wenn du in der Zwischenzeit selbst was geändert hast (Datei umbenannt, Funktion verschoben), erwähne das kurz, bevor du loslegst.

### `#bei` — Beifang sammeln

Vor jedem "fertig"-Meldemoment, frag Claude `#bei`. Claude schreibt dann eine vollständige Liste in `notizen/JJJJ-MM-TT_beifang.md` — Ideen, Probleme, Unsicherheiten, Beobachtungen.

KI-Agenten finden während der Arbeit Sachen, die nicht zum Auftrag gehören, sagen aber nichts darüber — weil sie meinen, das störe den Fokus. `#bei` macht das sichtbar. Du triagierst später, ob daraus eine Aufgabe wird.

### `#todo` — Aufgaben führen

`#todo Login-Tests schreiben, bis Freitag` hängt eine Aufgabe in `context.md` an. Bei der nächsten Session geht Claude die Liste durch und schlägt vor, was heute davon dran ist.

### `#oops` — Fehler protokollieren

Wenn etwas schief geht — Claude hat eine falsche Annahme getroffen, der Befehl ist gescheitert, du musstest korrigieren — sag `#oops`. Claude legt eine Notiz in `notizen/JJJJ-MM-TT_oops.md` an: was passiert ist, was richtig gewesen wäre, was beim nächsten Mal anders läuft.

Wenn dasselbe Oops dreimal auftaucht, überleg, ob du es mechanisch verhindern kannst — durch einen Hook (siehe unten) statt durch "nächstes Mal aufpassen".

### `#ahh` — Staunen festhalten

Wenn etwas Überraschendes passiert, im Guten wie im Schlechten — `#ahh`. Notiz in `notizen/JJJJ-MM-TT_ahh.md`. Das ist nicht Fehlerprotokoll und nicht Aufgabe, sondern: "hier war was, das wir uns merken sollten."

### `#rca` — Ursachensuche

Wenn etwas kaputt ist und du nicht weißt, warum — `#rca` zwingt Claude in einen Modus, der **erst Code liest, dann Hypothesen baut**. Das ist gegen den natürlichen Reflex von KI-Agenten, die schnell eine plausible Theorie anbieten und auf der losziehen.

Der RCA-Modus läuft so:

1. Du sagst was kaputt ist (Symptom, Fehlermeldung, was du erwartest hast).
2. Claude benennt **welches Repo / welche Datei** sie sich anschaut.
3. Claude liest die echten Quellen — Einstiegspunkt, Config, Datenstruktur. Bei Drittanbietern: offizielle Doku.
4. Claude sagt im Chat explizit: **"Code of Truth gelesen: `<file:lines>`"**.
5. *Erst dann* kommen Hypothesen.
6. Befund mit konkreten `file:line`-Verweisen.

Praktischer Tipp: wenn Claude vor Schritt 4 schon eine Theorie ausspuckt, schalt zurück. Sag "lies erst die Datei". Spart Stunden.

### `#audit` — Notizen ausschlachten

`notizen/` füllt sich. Beifang, Oops, Staunen — irgendwann sind 20 Dateien drin und du weißt nicht mehr, was du eigentlich gelernt hast.

`#audit` ist der Wartungs-Workflow. Claude liest alle Notizen und schreibt einen Bericht:

- Welche Fehler wiederholen sich? (Reife für einen Hook.)
- Welche Themen tauchen oft im Beifang auf? (Vielleicht eine eigene Aufgabe wert.)
- Welche Überraschungen lassen sich auswerten?

Einmal pro Woche, oder wenn `notizen/` mehr als ~10 Dateien hat. Ergebnis-Bericht landet wieder in `notizen/JJJJ-MM-TT_audit.md`.

Ohne Audit hast du einen Notizstapel; mit Audit wertet ihn das System aus.

---

## Statusline einrichten

Die Statusline ist die Zeile am unteren Rand deines Terminals, die Claude Code dir laufend einblendet — Modell, Context-Auslastung, ggf. Rate-Limits.

**Minimal-Variante** (`examples/statusline.sh`):

```
Claude Opus 4.7 | ctx 12%
```

**Reiche Variante** (`examples/statusline-full.sh`):

```
Claude Opus 4.7 | ctx 12% | 5h 34%→52% (2h17m) | wk 21%→24% (5d)
```

Die `→52%`-Pfeile sind Burn-Rate-Projektionen — *wo wirst du beim nächsten Reset wahrscheinlich stehen, wenn du im aktuellen Tempo weitermachst*.

### Aktivieren

1. Wahl treffen — minimal oder reich.
2. Datei nach `~/.claude/statusline.sh` kopieren:
   ```bash
   cp examples/statusline-full.sh ~/.claude/statusline.sh
   chmod +x ~/.claude/statusline.sh
   ```
3. In `~/.claude/settings.json` eintragen (siehe `examples/settings.json`):
   ```json
   "statusLine": {
     "type": "command",
     "command": "bash $HOME/.claude/statusline.sh"
   }
   ```
4. Claude Code neu starten.

Datenquelle der Scripte: stdin nach https://code.claude.com/docs/en/statusline ("Available data").

### Windows-Hinweis

Die mitgelieferten Scripte sind Bash. Auf Windows gibt es drei Wege:

- **WSL (Windows Subsystem for Linux)** — bash funktioniert nativ, Scripte laufen wie auf Mac/Linux. Empfohlen.
- **Git Bash** — kommt mit Git for Windows, reicht meist auch.
- **PowerShell-Variante** — gibt es im Repo nicht. Wenn du eine schreibst: PR willkommen (`CONTRIBUTING.md`). Die JSON-Felder sind dieselben, du musst nur Bash-Syntax durch PowerShell ersetzen.

Wenn du Claude Code in der VS-Code-Extension nutzt, ist die Statusline ohnehin nicht relevant — VS Code hat seine eigene Status-Bar.

---

## Hooks einrichten

Hooks sind kleine Shell-Scripte, die Claude Code an bestimmten Stellen ausführt:

- **`PreToolUse`** — bevor ein Tool läuft, kannst du blockieren.
- **`PostToolUse`** — nachdem ein Tool gelaufen ist, kannst du reagieren.
- **`UserPromptSubmit`** — wenn du einen Prompt schickst, kannst du Zusatzkontext mitgeben.
- **`Stop`** / **`SessionEnd`** / weitere — siehe https://code.claude.com/docs/en/hooks

Das Repo liefert zwei Beispiele in `hooks/`:

| Datei | Typ | Was sie tut |
|-------|-----|-------------|
| `block-dangerous-bash.sh` | `PreToolUse` (Bash) | Blockt `rm -rf /`, Fork-Bombs, `dd` auf Devices, `curl | bash`. |
| `inject-date.sh` | `UserPromptSubmit` | Gibt Claude bei jedem Prompt das aktuelle Datum mit (Modelle kennen es sonst nicht). |

### Aktivieren

1. Hooks nach `~/.claude/hooks/` kopieren und `chmod +x`.
2. In `~/.claude/settings.json` eintragen:
   ```json
   "hooks": {
     "PreToolUse": [
       {
         "matcher": "Bash",
         "hooks": [
           { "type": "command", "command": "bash $HOME/.claude/hooks/block-dangerous-bash.sh" }
         ]
       }
     ],
     "UserPromptSubmit": [
       {
         "hooks": [
           { "type": "command", "command": "bash $HOME/.claude/hooks/inject-date.sh" }
         ]
       }
     ]
   }
   ```

### Eigene Hooks schreiben

Suche dir einen Anlass:

- **Ein wiederholter Fehler** — Claude macht immer wieder X falsch. Schreib einen Hook, der X mechanisch verhindert.
- **Eine wiederkehrende Information** — Claude weiß Y nicht, das ändert sich aber selten. Schreib einen UserPromptSubmit-Hook, der Y mitgibt.

Im Hook bekommst du das Event als JSON auf `stdin`, gibst Anweisungen über `stdout` und Exit-Code zurück. Volle Doku: https://code.claude.com/docs/en/hooks

---

## `settings.json` anpassen

Datei: `~/.claude/settings.json`. Beispiel: `examples/settings.json`.

Wichtige Blöcke:

```json
{
  "statusLine": { ... },     // siehe oben
  "hooks": { ... },          // siehe oben

  "permissions": {
    "defaultMode": "default", // siehe "Permission-Modi" unten
    "allow": [                // diese Tool-Aufrufe ohne Rückfrage
      "Bash(ls:*)",
      "Bash(cat:*)",
      "Bash(grep:*)",
      "Bash(rg:*)",
      "Bash(git status)",
      "Bash(git diff:*)",
      "Bash(git log:*)"
    ],
    "deny": []                // diese Tool-Aufrufe nie
  },

  "effortLevel": "medium"    // wie viel Claude pro Antwort 'nachdenkt'
}
```

`permissions.allow` spart Klicks — Routine-Befehle laufen ohne dass du jeden einzeln freigeben musst. Achte darauf, nicht zu grob zu erlauben (`Bash(*)` ist offensichtlich nicht klug).

---

## Permission-Modi — Vorsicht beim Komfort

Claude Code kennt mehrere **Modi**, wie über Permissions entschieden wird. Modi hängen *über* der allow/deny-Liste — sie regeln den Grundton.

| Modus | Was passiert | Wann sinnvoll |
|-------|--------------|---------------|
| `default` | Bei jedem Tool, das nicht in `allow` steht, fragt Claude dich. | Default. Sicher, manchmal nervig. |
| `acceptEdits` | Edit / Write / MultiEdit laufen ohne Rückfrage, alle anderen Tools wie `default`. | Wenn du gerade refactorst und keine Lust hast, jedes Save zu bestätigen. |
| `plan` | Claude darf nichts schreiben oder ausführen, nur lesen und planen. Endet mit "Plan zur Freigabe". | Wenn du erst sehen willst, was sie tun *würde*. Hervorragend für riskante Eingriffe. |
| `bypassPermissions` | **Alle Tools laufen ohne Rückfrage** — auch `rm`, `curl`, alles. | **Nur in Sandbox / Container / Wegwerf-VM.** Auf der echten Maschine: nein. |

### Modus setzen

Pro Session beim Start:

```bash
claude --permission-mode acceptEdits
```

Permanent in `settings.json` (NICHT empfohlen für `bypassPermissions`):

```json
{
  "permissions": {
    "defaultMode": "acceptEdits"
  }
}
```

In der Session umschalten: `Shift+Tab` cycelt durch die Modi (Anzeige im Footer), oder `/permissions` öffnet das Berechtigungs-Menü.

### Der gefährliche Modus

`bypassPermissions` (oder das CLI-Flag `--dangerously-skip-permissions`) deaktiviert alle Rückfragen. Auf deiner Arbeitsmaschine bedeutet das: Claude kann ohne dein OK Dateien löschen, Netzwerk-Aufrufe machen, beliebige Befehle ausführen. Eine einzige falsche Annahme (Reflex 1!) kann teuer werden.

**Wann es trotzdem ok ist:**

- In einem Docker-Container, der nach der Session weggeworfen wird.
- In einer Wegwerf-VM oder Cloud-Sandbox.
- Auf einer Maschine, auf der nichts liegt, was du nicht reproduzieren kannst.

**Wann es nie ok ist:**

- Auf deinem Arbeitsrechner mit privaten Daten / Projekten.
- Auf Servern mit Produktion oder Kunden-Code.
- "Nur für einen Moment" — bleibt selten ein Moment.

### Mindeschutz, wenn du bypass nutzt

- **Hooks aktiv lassen.** `hooks/block-dangerous-bash.sh` aus diesem Repo blockt offensichtliche Katastrophen auch im Bypass-Modus, weil PreToolUse vor der Tool-Ausführung greift.
- **Wegwerf-Umgebung.** Vor `claude --dangerously-skip-permissions`: bist du sicher, dass du in dem Container / der VM bist, die du gleich löschen kannst? Wenn nicht: zurück zu `default`.
- **Kein Schreibzugriff auf Sensibles.** Mount nur das Projekt rein, nicht `$HOME`.

### Empfehlung für den Einstieg

Bleib bei **`default`** oder schalt für längere Edit-Sessions auf **`acceptEdits`**. `bypassPermissions` lass liegen, bis du eine Sandbox aufgesetzt hast, die wirklich Wegwerf ist.

---

## Weiter rein: Skills, Subagents, MCP

Wenn dir die Grundlagen sitzen — drei nächste Wege, in Stichworten:

- **Skills** — wiederverwendbare Anleitungen, die Claude auf bestimmte Trigger hin abruft. Z.B. "wenn ich `/sw-pdf` sage, generier mir ein PDF nach diesem Format". Doku: https://code.claude.com/docs/en/skills
- **Subagents / Agents** — speziell zugeschnittene Assistenten für bestimmte Aufgaben. Statt eine große CLAUDE.md für alles, hast du z.B. einen "Reviewer", einen "Tester", einen "Researcher" mit jeweils eigenem Verhalten. Doku: https://code.claude.com/docs/en/agents
- **MCP-Server** — Model Context Protocol. Externe Tools (GitHub, Notion, deine eigene Datenbank, Browser) andocken, sodass Claude sie nutzen kann. Doku: https://code.claude.com/docs/en/mcp

Hinweis für Free-Plan-Nutzung: **Subagents fressen Tokens**. Jeder Subagent ist ein eigener Mini-Claude. Lohnt sich, wenn die Aufgabe komplex ist; nicht, wenn du nur eine Frage hast.

---

## Free vs Pro — was sich praktisch unterscheidet

**Free** (Stand 2026, ohne Gewähr — prüf immer die aktuelle Anthropic-Doku):

- Kleinerer Context (typ. 200k Token statt 1M).
- Sonnet als Default, kein Opus.
- Niedrigere 5h- und 7d-Rate-Limits.

Was du davon merkst:

- **Lange Sessions kannst du nicht durchziehen** — `#h`/`#w` ist nicht nur ein Workflow, sondern eine praktische Notwendigkeit. Schreib oft Übergaben.
- **Kein Opus** heißt: bei kniffligen Refactors fällt die Qualität manchmal ab. Trick: schärfere Prompts, kleinere Aufgaben, klarere Erfolgskriterien (Reflex 4!).
- **Statusline lohnt sich** — du siehst, wann du dich dem 5h-Reset näherst.

**Pro / Max:**

- Mehr Tokens, mehr Limits, Opus optional, 1M-Context bei Max.
- Setup bleibt identisch — die Reflexe und Workflows in `CLAUDE.md` ändern sich nicht.

---

## Fragen / Mitmachen

Issues und Pull Requests willkommen — siehe `CONTRIBUTING.md`. Wer mitgeschrieben hat, steht in `AUTHORS.md` (Mensch und KI).
