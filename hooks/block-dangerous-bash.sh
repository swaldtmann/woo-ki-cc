#!/bin/bash
# PreToolUse-Hook für Bash: blockt vier Klassiker.
#
# Findet das Muster eine Übereinstimmung, gibt der Hook Exit-Code 2 zurück
# und Claude bekommt eine Begründung statt das Ergebnis.
#
# Greift NICHT bei: `eval 'rm -rf /'`, `sh -c '...'`, `cd / && rm -rf .`,
# long-options (`rm --recursive --force /`). Das ist Absicht — wer echten
# Schutz braucht: Container, VM, Read-only-Mount. Dieser Hook deckt die
# offensichtlichen Tippfehler-Pfade ab, kein vollständiges Sandboxing.
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

# rm -rf auf Wurzel oder $HOME ohne weitere Pfadangabe (auch ${HOME})
if echo "$cmd" | grep -qE 'rm\s+-[rRf]+\s+(/|/\*|\$\{?HOME\}?|~)\s*$'; then
    echo "Blockiert: 'rm -rf' auf Root oder \$HOME ohne weitere Pfade." >&2
    exit 2
fi

# dd direkt auf Festplatten-Device (sd*, nvme, disk*, mmcblk* SD, hd* legacy, xvd* Xen/EC2)
if echo "$cmd" | grep -qE 'dd\s+.*of=/dev/(sd[a-z]|nvme|disk[0-9]|mmcblk[0-9]|hd[a-z]|xvd[a-z])'; then
    echo "Blockiert: dd auf Festplatten-Device. Wenn das gewollt ist, bitte interaktiv im Terminal." >&2
    exit 2
fi

# Curl/Wget direkt in Shell pipen
if echo "$cmd" | grep -qE '(curl|wget)\s+[^|]+\|\s*(bash|sh|zsh)\b'; then
    echo "Blockiert: 'curl ... | bash' führt unbekannten Code aus. Erst herunterladen, dann prüfen, dann ausführen." >&2
    exit 2
fi

exit 0
