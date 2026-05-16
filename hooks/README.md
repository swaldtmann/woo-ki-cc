# Hooks

Hooks sind kleine Shell-Scripte, die Claude Code an bestimmten Stellen ausfuehrt — vor einem Tool-Aufruf, nach einer Stop-Aktion, beim Submit eines Prompts. Damit machst du aus einem Vorsatz ("ich pruefe immer, ob...") einen Mechanismus ("das System pruefe immer, ob...").

**Mechanismus schlaegt Vorsatz** — wer sechsmal denselben Fehler macht, fixed das nicht mit Erinnerungen.

## Zwei Beispiele

| Datei | Typ | Was sie tut |
|-------|-----|-------------|
| `block-dangerous-bash.sh` | `PreToolUse` (Bash) | Blockt offensichtlich gefaehrliche Shell-Befehle (`rm -rf /`, `:(){:|:&};:`). |
| `inject-date.sh` | `UserPromptSubmit` | Haengt das heutige Datum an deinen Prompt — Claude weiss sonst nicht, welcher Tag ist. |

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

1. Such dir einen Anlass: "Ich mache wiederholt denselben Fehler X" oder "Claude weiss Y nicht, das aendert sich aber selten".
2. Schreib ein Script, das beim passenden Event triggert.
3. Im Hook-Script bekommst du den Event als JSON auf stdin, gibst Anweisungen ueber stdout/Exit-Code zurueck.

Vollstaendige Hook-Doku: https://code.claude.com/docs/en/hooks
