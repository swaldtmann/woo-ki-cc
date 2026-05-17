# Anleitung — woo-ki-cc

Hier ist die lange Form. Wenn du nur loslegen willst: `README.md` reicht. Wenn du verstehen willst, *warum* die Sachen so sind und *wie* du sie auf dein eigenes Setup zuschneidest: lies hier weiter.

## Inhalt

- [Wo laeuft Claude Code](#wo-laeuft-claude-code)
- [Vorbereitung](#vorbereitung)
- [Schritt 1 — Claude Code installieren](#schritt-1--claude-code-installieren)
- [Schritt 2 — `CLAUDE.md` in dein Projekt](#schritt-2--claudemd-in-dein-projekt)
- [Schritt 3 — Erste Session](#schritt-3--erste-session)
- [Schritt 4 — Shell-Alias fuer den Projektstart](#schritt-4--shell-alias-fuer-den-projektstart)
- [Die vier Reflexe — was sie wirklich bewirken](#die-vier-reflexe--was-sie-wirklich-bewirken)
- [Die sieben Workflows — wie du sie nutzt](#die-sieben-workflows--wie-du-sie-nutzt)
- [Statusline einrichten](#statusline-einrichten)
- [Hooks einrichten](#hooks-einrichten)
- [`settings.json` anpassen](#settingsjson-anpassen)
- [Permission-Modi — Vorsicht beim Komfort](#permission-modi--vorsicht-beim-komfort)
- [Weiter rein: Skills, Subagents, MCP](#weiter-rein-skills-subagents-mcp)
- [Free vs Pro — was sich praktisch unterscheidet](#free-vs-pro--was-sich-praktisch-unterscheidet)

---

## Wo laeuft Claude Code

Claude Code ist nicht an eine einzelne Oberflaeche gebunden. Du hast die Wahl:

| Variante | Wer es nutzt |
|----------|--------------|
| **CLI im Terminal** — `claude` aufrufen | Wer ohnehin im Terminal lebt. Schnell, leichtgewichtig, kommt mit `tmux`/`screen` klar — beides ist aber **nicht erforderlich**. |
| **VS Code Extension** | Wahrscheinlich der bequemste Einstieg fuer IT-Leute, die nicht ausschliesslich CLI arbeiten. Code-Diffs visuell, Hover, Navigation. |
| **JetBrains Extension** | IntelliJ, PyCharm, GoLand, WebStorm usw. — analog zur VS-Code-Variante. |
| **Desktop-App** (Mac/Windows) | Eigenstaendiges Fenster. Gut, wenn du Claude losgeloest vom Editor laufen lassen willst. Eigene Anleitung: [`desktop.md`](desktop.md). |
| **Web-App** auf https://claude.ai/code | Ohne Installation, Browser reicht. Praktisch unterwegs oder auf fremden Geraeten. Eigene Anleitung: [`web.md`](web.md). |

**Alle Varianten lesen `CLAUDE.md` aus dem Projektordner** — die Reflexe und Workflows wirken in jeder gleich. Hooks und Statusline funktionieren primaer in CLI und Desktop-App; in den IDE-Extensions teils begrenzt (siehe deren Doku).

Empfehlung fuer den Anfang: VS Code Extension *oder* CLI. Wahl ist Geschmackssache.

### Was vom Repo wo greift

Nicht jedes Feature dieses Repos laeuft in jeder Variante. Stand 2026-05 — pruef die jeweilige Claude-Code-Doku, wenn du dir unsicher bist:

| Feature | CLI | VS Code | JetBrains | Desktop | Web (claude.ai/code) |
|---------|:---:|:-------:|:---------:|:-------:|:--------------------:|
| `CLAUDE.md` Auto-Load | ja | ja | ja | ja | ja (per Projekt-Anbindung) |
| `context.md` + `notizen/` | ja | ja | ja | ja | ja |
| Tags (`#h`, `#w`, ...) | ja | ja | ja | ja | ja (reine Konvention, kein Tool) |
| Statusline | **ja** | nein (IDE hat eigene Status-Bar) | nein | unklar | nein |
| Hooks (`PreToolUse` etc.) | **ja** | wahrscheinlich ja | wahrscheinlich ja | wahrscheinlich ja | nein (kein lokales Filesystem) |
| `settings.json` Permissions | ja | ja | ja | ja | begrenzt |

**Reflexe + Workflows** in `CLAUDE.md` wirken **ueberall**. Die Mechanik-Schicht (Statusline + Hooks + Permission-Allow/Deny) lebt vor allem in CLI und Desktop; in IDE-Extensions teilweise, im Web kaum.

Praktischer Tipp: VS Code + CLI parallel — IDE zum Coden und Diff-Lesen, CLI wenn du Hooks oder die Statusline brauchst.

## Vorbereitung

Du brauchst:

- Ein Terminal (Bash oder Zsh).
- `git` (kommt auf macOS und Linux meist mit, auf Windows: WSL oder Git for Windows).
- `jq` fuer die Statusline und manche Hooks (`brew install jq` auf macOS, `apt install jq` auf Debian/Ubuntu).
- Einen Anthropic-Account — kostenloses Konto reicht zum Anfangen.

## Schritt 1 — Claude Code installieren

Anthropic dokumentiert die Installation hier: https://docs.claude.com/claude-code

Die zwei haeufigsten Wege:

```bash
# Per npm (cross-platform)
npm install -g @anthropic-ai/claude-code

# Per Homebrew (macOS / Linux mit brew)
brew install claude-code
```

Danach in einem Terminal `claude` aufrufen. Beim ersten Start fragt Claude nach deinem Account und einer Login-Methode (Browser-Login mit dem Anthropic-Konto ist der einfachste Weg).

## Schritt 2 — `CLAUDE.md` in dein Projekt

Klon dir dieses Repo, oder kopier dir die Dateien einzeln rueber:

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

Sag etwa: "Lies CLAUDE.md und gib mir eine Kurzfassung der Regeln, an die du dich halten wirst." Wenn die Antwort die vier Reflexe und die sieben Workflows enthaelt, ist alles eingerichtet.

Beende die Session mit `#h` — Claude schreibt eine Uebergabe in `context.md`. Naechste Session: `claude` starten, `#w` sagen, weiter geht's.

---

## Schritt 4 — Shell-Alias fuer den Projektstart

Damit `CLAUDE.md` wirkt, muss Claude Code **im Projekt-Ordner** gestartet werden — sonst liest es die Datei nicht. Wenn du das taeglich tust und manuell `cd` und `claude` tippst, vergisst du es eines Tages und arbeitest "ohne" — die KI wirkt schlechter und du weisst nicht warum.

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

Ab jetzt: `projekt` getippt — du landest im Ordner, Claude startet, `CLAUDE.md` greift. Fuer mehrere Projekte einfach mehrere Funktionen:

```bash
api()   { cd ~/projekte/api   && claude "$@"; }
shop()  { cd ~/projekte/shop  && claude "$@"; }
notes() { cd ~/projekte/notes && claude "$@"; }
```

### Warum nicht einfach im Home-Verzeichnis starten?

Du kannst `claude` auch aus `~` starten. Dann liest Claude aber `~/CLAUDE.md` (wenn vorhanden) oder gar nichts Projekt-Spezifisches. Die Reflexe und Workflows aus diesem Repo greifen erst, wenn Claude die `CLAUDE.md` *deines Projekts* findet — und das tut es zuverlaessig nur, wenn das Arbeitsverzeichnis stimmt.

### `Bash`-Subshells in Hooks

Hooks und Bash-Befehle, die Claude waehrend der Session aufruft, laufen in **Subshells ohne deine `.zshrc`/`.bashrc`**. Wenn du dort Aliase oder PATH-Eintraege definierst und ein Hook die braucht — funktioniert nicht. Loesungen:

- PATH explizit im Hook setzen (`export PATH="/opt/homebrew/bin:$PATH"` o.ae.).
- Tools mit vollem Pfad aufrufen (`/usr/local/bin/jq` statt `jq`).
- Alias durch Funktion ersetzen und Funktion auch direkt im Hook-Script definieren.

Es zahlt sich aus, das frueh zu wissen — wer eine Stunde sucht "warum laeuft mein Hook im Terminal aber nicht in der Session", landet meistens hier.

---

## Die vier Reflexe — was sie wirklich bewirken

### Reflex 1 — Denken vor Tun

Das aergerlichste Verhalten von KI-Agenten: sie machen einfach. Du sagst "behebe den Fehler", und die KI fixt nicht den Fehler, sondern eine Annahme, die sie nebenbei getroffen hat.

Reflex 1 zwingt sie, Annahmen explizit zu machen. Wenn du etwa "die Aufgabe ist nicht klar" sagst und Claude versteht das anders als du, soll Claude *nachfragen*, nicht raten.

**Beispiel:** Du sagst "mach die Tabelle schneller". Claude koennte annehmen: "schneller" = bessere Render-Performance. Tatsaechlich meinst du: "schneller fertig", also der Server soll die JSON-Antwort frueher liefern. Mit Reflex 1 fragt Claude: "Meinst du Frontend-Render oder Backend-Antwortzeit?" Du sparst eine halbe Stunde.

### Reflex 2 — Einfach halten

KI hat eine Tendenz, "vorsorglich" Code zu schreiben — Helper-Funktionen, Abstraktionen, Konfig-Flags fuer Features, die nie kommen.

Reflex 2 ist ein Stop-Schild. Drei aehnliche Zeilen sind besser als ein verfruehter Helper. Eine Funktion erst extrahieren, wenn sie wirklich woanders gebraucht wird.

### Reflex 3 — Chirurgisch aendern

KI sieht beim Bugfix oft auch "Verbesserungspotenzial" — und packt Refactoring, Umbenennung und Stil-Updates in dieselbe Aenderung. Das macht jeden Pull Request unlesbar.

Reflex 3 sagt: was die Aufgabe nicht erfordert, ruehrst du nicht an. Bugfix heisst Bugfix. Wenn du nebenbei eine schlechte Stelle siehst — sag es als Hinweis, nicht als zusaetzliche Aenderung im selben Commit.

### Reflex 4 — Ziel statt Schritte

Wenn du Claude einen Plan vorgibst, fuehrt sie diesen Plan stur aus — auch dann, wenn der Plan falsch ist.

Reflex 4 dreht das um. Du sagst: "am Ende soll Test X gruen sein" oder "die Funktion soll JSON zurueckgeben mit Feldern A/B/C". Claude waehlt den Weg. Wenn der Weg besser ist als der, den du dir vorgestellt hast: gut. Wenn nicht: du siehst sofort, dass das Ziel nicht erreicht wurde.

Praktischer Tipp: bei `#todo` formulier die Aufgabe so, dass *die Pruefung* drinsteht. "Login muss mit Email/Passwort funktionieren und auf 'Falsch' eine Fehlermeldung zeigen" ist besser als "Login-Form bauen".

---

## Die sieben Workflows — wie du sie nutzt

### `#h` — Uebergabe schreiben

Am Ende einer Session: tippe `#h`. Claude liest, was passiert ist, und schreibt eine kompakte Zusammenfassung in `context.md`:

- Was haben wir gemacht?
- Was ist offen?
- Was ist der naechste Schritt?

Tipp: lies die Uebergabe kurz durch. Wenn sie etwas weglaesst, was dir wichtig ist, korrigier eine Zeile. `context.md` ist das Gedaechtnis — nimm es ernst.

### `#w` — Wiederaufnahme

Naechste Session, `claude` starten, `#w` tippen. Claude liest `context.md` und knuepft an. Wenn du in der Zwischenzeit selbst was geaendert hast (Datei umbenannt, Funktion verschoben), erwaehne das kurz, bevor du loslegst.

### `#bei` — Beifang sammeln

Vor jedem "fertig"-Meldemoment, frag Claude `#bei`. Sie schreibt dann eine vollstaendige Liste in `notizen/JJJJ-MM-TT_beifang.md` — Ideen, Probleme, Unsicherheiten, Beobachtungen.

KI-Agenten finden waehrend der Arbeit Sachen, die nicht zum Auftrag gehoeren, sagen aber nichts darueber — weil sie meinen, das stoere den Fokus. `#bei` macht das sichtbar. Du triagierst spaeter, ob daraus eine Aufgabe wird.

### `#todo` — Aufgaben fuehren

`#todo Login-Tests schreiben, bis Freitag` haengt eine Aufgabe in `context.md` an. Bei der naechsten Session geht Claude die Liste durch und schlaegt vor, was sie heute davon nehmen kann.

### `#oops` — Fehler protokollieren

Wenn etwas schief geht — Claude hat eine falsche Annahme getroffen, der Befehl ist gescheitert, du musstest korrigieren — sag `#oops`. Claude legt eine Notiz in `notizen/JJJJ-MM-TT_oops.md` an: was passiert ist, was richtig gewesen waere, was ihr nächstes Mal anders macht.

Wenn dasselbe Oops dreimal auftaucht, ueberleg, ob du es mechanisch verhindern kannst — durch einen Hook (siehe unten) statt durch "naechstes Mal aufpassen".

### `#ahh` — Staunen festhalten

Wenn etwas Ueberraschendes passiert, im Guten wie im Schlechten — `#ahh`. Notiz in `notizen/JJJJ-MM-TT_ahh.md`. Das ist nicht Fehlerprotokoll und nicht Aufgabe, sondern: "hier war was, das wir uns merken sollten."

### `#rca` — Ursachensuche

Wenn etwas kaputt ist und du nicht weisst, warum — `#rca` zwingt Claude in einen Modus, der **erst Code liest, dann Hypothesen baut**. Das ist gegen den natuerlichen Reflex von KI-Agenten, die schnell eine plausible Theorie anbieten und auf der losziehen.

Der RCA-Modus laeuft so:

1. Du sagst was kaputt ist (Symptom, Fehlermeldung, was du erwartest hast).
2. Claude benennt **welches Repo / welche Datei** sie sich anschaut.
3. Claude liest die echten Quellen — Einstiegspunkt, Config, Datenstruktur. Bei Drittanbietern: offizielle Doku.
4. Claude sagt im Chat explizit: **"Code of Truth gelesen: `<file:lines>`"**.
5. *Erst dann* kommen Hypothesen.
6. Befund mit konkreten `file:line`-Verweisen.

Praktischer Tipp: wenn Claude vor Schritt 4 schon eine Theorie ausspuckt, schalt zurueck. Sag "lies erst die Datei". Spart Stunden.

### `#audit` — Notizen ausschlachten

`notizen/` fuellt sich. Beifang, Oops, Staunen — irgendwann sind 20 Dateien drin und du weisst nicht mehr, was du eigentlich gelernt hast.

`#audit` ist der Wartungs-Workflow. Claude liest alle Notizen und schreibt einen Bericht:

- Welche Fehler wiederholen sich? (Reife fuer einen Hook.)
- Welche Themen tauchen oft im Beifang auf? (Vielleicht eine eigene Aufgabe wert.)
- Welche Ueberraschungen lassen sich auswerten?

Einmal pro Woche, oder wenn `notizen/` mehr als ~10 Dateien hat. Ergebnis-Bericht landet wieder in `notizen/JJJJ-MM-TT_audit.md`.

Wert: das System wird klueger. Ohne Audit haben wir einen Notizstapel; mit Audit hat der Stapel einen Effekt.

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

Die `→52%`-Pfeile sind Burn-Rate-Projektionen — *wo wirst du beim naechsten Reset wahrscheinlich stehen, wenn du im aktuellen Tempo weitermachst*.

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

Hooks sind kleine Shell-Scripte, die Claude Code an bestimmten Stellen ausfuehrt:

- **`PreToolUse`** — bevor ein Tool laeuft, kannst du blockieren.
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
- **Eine wiederkehrende Information** — Claude weiss Y nicht, das aendert sich aber selten. Schreib einen UserPromptSubmit-Hook, der Y mitgibt.

Im Hook bekommst du das Event als JSON auf `stdin`, gibst Anweisungen ueber `stdout` und Exit-Code zurueck. Volle Doku: https://code.claude.com/docs/en/hooks

---

## `settings.json` anpassen

Datei: `~/.claude/settings.json`. Beispiel: `examples/settings.json`.

Wichtige Bloecke:

```json
{
  "statusLine": { ... },     // siehe oben
  "hooks": { ... },          // siehe oben

  "permissions": {
    "allow": [               // diese Tool-Aufrufe ohne Rueckfrage
      "Bash(ls:*)",
      "Bash(git status)",
      "Bash(git diff:*)"
    ],
    "deny": []               // diese Tool-Aufrufe nie
  },

  "effortLevel": "medium"    // wie viel Claude pro Antwort 'nachdenkt'
}
```

`permissions.allow` spart Klicks — Routine-Befehle laufen ohne dass du jeden einzeln freigeben musst. Achte darauf, nicht zu grob zu erlauben (`Bash(*)` ist offensichtlich nicht klug).

---

## Permission-Modi — Vorsicht beim Komfort

Claude Code kennt mehrere **Modi**, wie ueber Permissions entschieden wird. Modi haengen *ueber* der allow/deny-Liste — sie regeln den Grundton.

| Modus | Was passiert | Wann sinnvoll |
|-------|--------------|---------------|
| `default` | Bei jedem Tool, das nicht in `allow` steht, fragt Claude dich. | Default. Sicher, manchmal nervig. |
| `acceptEdits` | Edit / Write / MultiEdit laufen ohne Rueckfrage, alle anderen Tools wie `default`. | Wenn du gerade refactorst und keine Lust hast, jedes Save zu bestaetigen. |
| `plan` | Claude darf nichts schreiben oder ausfuehren, nur lesen und planen. Endet mit "Plan zur Freigabe". | Wenn du erst sehen willst, was sie tun *wuerde*. Hervorragend fuer riskante Eingriffe. |
| `bypassPermissions` | **Alle Tools laufen ohne Rueckfrage** — auch `rm`, `curl`, alles. | **Nur in Sandbox / Container / Wegwerf-VM.** Auf der echten Maschine: nein. |

### Modus setzen

Pro Session beim Start:

```bash
claude --permission-mode acceptEdits
```

Permanent in `settings.json` (NICHT empfohlen fuer `bypassPermissions`):

```json
{
  "permissions": {
    "defaultMode": "acceptEdits"
  }
}
```

In der Session umschalten: `Shift+Tab` cycelt durch die Modi (Anzeige im Footer), oder `/permissions` oeffnet das Berechtigungs-Menue.

### Der gefaehrliche Modus

`bypassPermissions` (oder das CLI-Flag `--dangerously-skip-permissions`) deaktiviert alle Rueckfragen. Auf deiner Arbeitsmaschine bedeutet das: Claude kann ohne dein OK Dateien loeschen, Netzwerk-Aufrufe machen, beliebige Befehle ausfuehren. Eine einzige falsche Annahme (Reflex 1!) kann teuer werden.

**Wann es trotzdem ok ist:**

- In einem Docker-Container, der nach der Session weggeworfen wird.
- In einer Wegwerf-VM oder Cloud-Sandbox.
- Auf einer Maschine, auf der nichts liegt, was du nicht reproduzieren kannst.

**Wann es nie ok ist:**

- Auf deinem Arbeitsrechner mit privaten Daten / Projekten.
- Auf Servern mit Produktion oder Kunden-Code.
- "Nur fuer einen Moment" — bleibt selten ein Moment.

### Mindeschutz, wenn du bypass nutzt

- **Hooks aktiv lassen.** `hooks/block-dangerous-bash.sh` aus diesem Repo blockt offensichtliche Katastrophen auch im Bypass-Modus, weil PreToolUse vor der Tool-Ausfuehrung greift.
- **Wegwerf-Umgebung.** Vor `claude --dangerously-skip-permissions`: bist du sicher, dass du in dem Container / der VM bist, die du gleich loeschen kannst? Wenn nicht: zurueck zu `default`.
- **Kein Schreibzugriff auf Sensibles.** Mount nur das Projekt rein, nicht `$HOME`.

### Empfehlung fuer Lo

Bleib bei **`default`** oder schalt fuer laengere Edit-Sessions auf **`acceptEdits`**. `bypassPermissions` lass liegen, bis du eine Sandbox aufgesetzt hast, die wirklich Wegwerf ist.

---

## Weiter rein: Skills, Subagents, MCP

Wenn dir die Grundlagen sitzen — drei naechste Wege, in Stichworten:

- **Skills** — wiederverwendbare Anleitungen, die Claude auf bestimmte Trigger hin abruft. Z.B. "wenn ich `/sw-pdf` sage, generier mir ein PDF nach diesem Format". Doku: https://code.claude.com/docs/en/skills
- **Subagents / Agents** — speziell zugeschnittene Assistenten fuer bestimmte Aufgaben. Statt eine grosse CLAUDE.md fuer alles, hast du z.B. einen "Reviewer", einen "Tester", einen "Researcher" mit jeweils eigenem Verhalten. Doku: https://code.claude.com/docs/en/agents
- **MCP-Server** — Model Context Protocol. Externe Tools (GitHub, Notion, deine eigene Datenbank, Browser) andocken, sodass Claude sie nutzen kann. Doku: https://code.claude.com/docs/en/mcp

Hinweis fuer Free-Plan-Nutzung: **Subagents frisst Tokens**. Jeder Subagent ist ein eigener Mini-Claude. Lohnt sich, wenn die Aufgabe komplex ist; nicht, wenn du nur eine Frage hast.

---

## Free vs Pro — was sich praktisch unterscheidet

**Free** (Stand 2026, ohne Gewaehr — pruef immer die aktuelle Anthropic-Doku):

- Kleinerer Context (typ. 200k Token statt 1M).
- Sonnet als Default, kein Opus.
- Niedrigere 5h- und 7d-Rate-Limits.

Was du davon merkst:

- **Lange Sessions kannst du nicht durchziehen** — `#h`/`#w` ist nicht nur ein Workflow, sondern eine praktische Notwendigkeit. Schreib oft Uebergaben.
- **Kein Opus** heisst: bei kniffligen Refactors faellt die Qualitaet manchmal ab. Trick: schaerfere Prompts, kleinere Aufgaben, klarere Erfolgskriterien (Reflex 4!).
- **Statusline ist Gold wert** — du siehst, wann du dich dem 5h-Reset naeherst.

**Pro / Max:**

- Mehr Tokens, mehr Limits, Opus optional, 1M-Context bei Max.
- Setup bleibt identisch — die Reflexe und Workflows in `CLAUDE.md` aendern sich nicht.

---

## Fragen / Mitmachen

Issues und Pull Requests willkommen — siehe `CONTRIBUTING.md`. Wer mitgeschrieben hat, steht in `AUTHORS.md` (Mensch und KI).
