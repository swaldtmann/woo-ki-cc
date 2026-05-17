#!/bin/bash
# UserPromptSubmit-Hook: hängt das heutige Datum an Claudes Context.
#
# Claude weiß von sich aus nicht, welcher Tag heute ist (das Modell hat
# einen Trainings-Cutoff). Mit diesem Hook bekommt Claude bei jedem
# Prompt-Submit das aktuelle Datum als Zusatzkontext mit.
#
# Format: gibt JSON auf stdout aus, das Claude als zusätzlichen Kontext
# einliest. Doku: https://code.claude.com/docs/en/hooks
#
# Anpassbar: Du kannst hier auch Reminder, Wochentag, Tageszeit, oder
# eigene Hinweise einbauen — alles was Claude beim Antworten wissen soll.

# jq fehlt: sauber raus, sonst würde der Hook stumm versagen
command -v jq >/dev/null 2>&1 || exit 0

today=$(date '+%A, %d.%m.%Y')

jq -n --arg ctx "Heute ist $today." '{
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    additionalContext: $ctx
  }
}'
