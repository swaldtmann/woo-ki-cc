# woo-ki-cc — Hooks

Hooks sind kleine Shell-Scripte, die Claude Code an bestimmten Stellen ausführt — vor einem Tool-Aufruf, nach einer Stop-Aktion, beim Submit eines Prompts. Damit machst du aus einem Vorsatz ("ich prüfe immer, ob...") einen Mechanismus ("das System prüft immer, ob...").

**Mechanismus schlägt Vorsatz** — wer sechsmal denselben Fehler macht, fixt das nicht mit Erinnerungen.

## Zwei Beispiele

| Datei | Typ | Was sie tut |
|-------|-----|-------------|
| `block-dangerous-bash.sh` | `PreToolUse` (Bash) | Blockt vier Klassiker: Fork-Bomb, `rm -rf /` bzw. `~`, `dd of=/dev/...`, `curl\|bash`. Fängt nicht alles (wer per `eval`, `sh -c` oder `cd / && rm -rf .` ausweicht, kommt durch). Kein Sandboxing-Ersatz — für echten Schutz: Container/VM. |
| `inject-date.sh` | `UserPromptSubmit` | Hängt das heutige Datum an deinen Prompt — Claude weiß sonst nicht, welcher Tag ist. |

## Aktivieren

In `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash $HOME/.claude/hooks/block-dangerous-bash.sh"
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash $HOME/.claude/hooks/inject-date.sh"
          }
        ]
      }
    ]
  }
}
```

Dann Scripte nach `~/.claude/hooks/` kopieren und `chmod +x`.

## Eigene Hooks schreiben

1. Such dir einen Anlass: "Ich mache wiederholt denselben Fehler X" oder "Claude weiß Y nicht, das ändert sich aber selten".
2. Schreib ein Script, das beim passenden Event triggert.
3. Im Hook-Script bekommst du den Event als JSON auf stdin, gibst Anweisungen über stdout/Exit-Code zurück.

Vollständige Hook-Doku: https://code.claude.com/docs/en/hooks
