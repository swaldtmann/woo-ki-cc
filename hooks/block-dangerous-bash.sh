#!/bin/bash
# PreToolUse-Hook fuer Bash: blockt offensichtlich gefaehrliche Befehle.
#
# Greift, bevor Claude einen Bash-Befehl ausfuehrt. Findet das Muster eine
# Uebereinstimmung, gibt der Hook Exit-Code 2 zurueck und Claude bekommt
# eine Begruendung statt das Ergebnis.
#
# stdin: JSON mit Tool-Aufruf
# Wir parsen .tool_input.command und matchen gegen eine kleine Blacklist.

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // empty')

[ -z "$cmd" ] && exit 0

# Fork-Bomb
if echo "$cmd" | grep -qE ':\(\)\s*\{\s*:\|:&\s*\}'; then
    echo "Blockiert: Fork-Bomb erkannt." >&2
    exit 2
fi

# rm -rf auf Wurzel oder $HOME ohne weitere Pfadangabe
if echo "$cmd" | grep -qE 'rm\s+-[rRf]+\s+(/|/\*|\$HOME|~)\s*$'; then
    echo "Blockiert: 'rm -rf' auf Root oder \$HOME ohne weitere Pfade." >&2
    exit 2
fi

# dd direkt auf Festplatten-Device
if echo "$cmd" | grep -qE 'dd\s+.*of=/dev/(sd[a-z]|nvme|disk[0-9])'; then
    echo "Blockiert: dd auf Festplatten-Device. Wenn das gewollt ist, bitte interaktiv im Terminal." >&2
    exit 2
fi

# Curl/Wget direkt in Shell pipen
if echo "$cmd" | grep -qE '(curl|wget)\s+[^|]+\|\s*(bash|sh|zsh)\b'; then
    echo "Blockiert: 'curl ... | bash' fuehrt unbekannten Code aus. Erst herunterladen, dann pruefen, dann ausfuehren." >&2
    exit 2
fi

exit 0
