#!/bin/bash
# Reicher Statusline-Helper fuer Claude Code.
#
# Zeigt Modellname, Context-Auslastung und Rate-Limit-Verbrauch (5h + 7d)
# inklusive Burn-Rate-Projektion und Reset-Zeit.
#
# Datenquelle: stdin nach https://code.claude.com/docs/en/statusline (Available data).
#
# Beispiel-Output:
#   Claude Opus 4.7 | ctx 12% | 5h 34%→52% (2h17m) | wk 21%→24% (5d)
#
# Burn-Rate-Pfeil (→Z%) erscheint, sobald genug Historie da ist (~2 Min).
#
# Aktivieren:
#   1. Datei nach ~/.claude/statusline.sh kopieren
#   2. chmod +x ~/.claude/statusline.sh
#   3. In ~/.claude/settings.json eintragen:
#        "statusLine": {
#          "type": "command",
#          "command": "bash $HOME/.claude/statusline.sh"
#        }
#
# Voraussetzung: jq + awk + date. parse_reset_ts faellt von BSD-date (macOS)
# auf GNU-date (Linux) zurueck — beide Wege probiert, kein OS-Switch noetig.
# Auf Windows: WSL oder Git Bash. Native PowerShell-Variante: PR willkommen.

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
used=$(echo "$input"  | jq -r '.context_window.used_percentage // empty')
h5_util=$(echo "$input"  | jq -r '.rate_limits.five_hour.used_percentage // empty')
h5_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
wk_util=$(echo "$input"  | jq -r '.rate_limits.seven_day.used_percentage // empty')
wk_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Historie fuer Burn-Rate
CACHE_DIR="$HOME/.claude/usage-cache"
HISTORY_FILE="$CACHE_DIR/history.tsv"
HISTORY_MAX_MIN=60
mkdir -p "$CACHE_DIR"

now_epoch=$(date +%s)
if [ -n "$h5_util" ] || [ -n "$wk_util" ]; then
    echo -e "${now_epoch}\t${h5_util:-0}\t${wk_util:-0}" >> "$HISTORY_FILE"
    cutoff=$(( now_epoch - HISTORY_MAX_MIN * 60 ))
    awk -F'\t' -v c="$cutoff" '$1 >= c' "$HISTORY_FILE" > "$HISTORY_FILE.tmp" 2>/dev/null \
        && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
fi
oldest=$(head -n1 "$HISTORY_FILE" 2>/dev/null)

parse_reset_ts() {
    local r="$1"
    [ -z "$r" ] || [ "$r" = "null" ] && return
    if [[ "$r" =~ ^[0-9]+$ ]]; then
        echo "$r"
    else
        # macOS-BSD-date zuerst, sonst GNU-date (Linux)
        date -j -f "%Y-%m-%dT%H:%M:%S" "${r%.*}" "+%s" 2>/dev/null \
            || date -d "${r%.*}" +%s 2>/dev/null
    fi
}

format_reset() {
    local target; target=$(parse_reset_ts "$1")
    [ -z "$target" ] && { echo ""; return; }
    local diff=$(( target - $(date +%s) ))
    [ "$diff" -lt 0 ] && { echo ""; return; }
    if [ "$diff" -ge 86400 ]; then echo "$((diff/86400))d"
    elif [ "$diff" -ge 3600 ]; then echo "$((diff/3600))h$(((diff%3600)/60))m"
    else echo "$((diff/60))m"
    fi
}

project_at_reset() {
    local cur="$1" reset="$2" col="$3"
    [ -z "$cur" ] || [ -z "$reset" ] || [ "$reset" = "null" ] && { echo ""; return; }
    [ -z "$oldest" ] && { echo ""; return; }
    local old_ts old_val target_ts span_s rate proj
    old_ts=$(echo "$oldest" | cut -f1)
    old_val=$(echo "$oldest" | cut -f"$col")
    target_ts=$(parse_reset_ts "$reset")
    [ -z "$target_ts" ] && { echo ""; return; }
    span_s=$(( now_epoch - old_ts ))
    [ "$span_s" -lt 120 ] && { echo ""; return; }
    rate=$(awk -v c="$cur" -v o="$old_val" -v s="$span_s" 'BEGIN{ if(s<=0){print 0;exit} printf "%.6f", (c-o)/s }')
    local remain_s=$(( target_ts - now_epoch ))
    [ "$remain_s" -le 0 ] && { echo ""; return; }
    proj=$(awk -v c="$cur" -v r="$rate" -v rs="$remain_s" 'BEGIN{ printf "%.0f", c + r*rs }')
    local cur_int; cur_int=$(echo "$cur" | awk '{printf "%.0f", $1}')
    [ "$proj" -le "$cur_int" ] 2>/dev/null && { echo ""; return; }
    [ "$proj" -ge 100 ] && proj=99
    echo "$proj"
}

parts=("$model")
[ -n "$used" ] && parts+=("ctx $(echo "$used" | cut -d. -f1)%")

if [ -n "$h5_util" ]; then
    h5_int=$(echo "$h5_util" | awk '{printf "%.0f", $1}')
    h5_proj=$(project_at_reset "$h5_util" "$h5_reset" 2)
    h5_r=$(format_reset "$h5_reset")
    parts+=("5h ${h5_int}%${h5_proj:+→${h5_proj}%}${h5_r:+ (${h5_r})}")
fi
if [ -n "$wk_util" ]; then
    wk_int=$(echo "$wk_util" | awk '{printf "%.0f", $1}')
    wk_proj=$(project_at_reset "$wk_util" "$wk_reset" 3)
    wk_r=$(format_reset "$wk_reset")
    parts+=("wk ${wk_int}%${wk_proj:+→${wk_proj}%}${wk_r:+ (${wk_r})}")
fi

out=""
for p in "${parts[@]}"; do
    if [ -z "$out" ]; then out="$p"; else out="$out | $p"; fi
done
printf "%s" "$out"
