#!/bin/bash
# Minimaler Statusline-Helper fuer Claude Code.
#
# Zeigt Modellname und Context-Auslastung in Prozent.
# Quelle: https://code.claude.com/docs/en/statusline (Available data)
#
# Aktivieren:
#   1. Diese Datei nach ~/.claude/statusline.sh kopieren
#   2. chmod +x ~/.claude/statusline.sh
#   3. In ~/.claude/settings.json eintragen:
#        "statusLine": {
#          "type": "command",
#          "command": "bash $HOME/.claude/statusline.sh"
#        }
#   4. Claude Code neu starten
#
# Voraussetzung: jq installiert (brew install jq / apt install jq).

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

if [ -n "$used" ]; then
    printf "%s | ctx %s%%" "$model" "$(echo "$used" | cut -d. -f1)"
else
    printf "%s | ctx --" "$model"
fi
