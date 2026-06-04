#!/usr/bin/env bash

# Emit Waybar JSON for currently active MPRIS media.
# Prefers a playing player, falls back to paused media.

set -o pipefail

command -v playerctl >/dev/null 2>&1 || exit 0
command -v jq >/dev/null 2>&1 || exit 0

chosen=""
chosen_status=""
paused_candidate=""
paused_status=""

while IFS= read -r player; do
  [[ -z "$player" ]] && continue

  status=$(playerctl -p "$player" status 2>/dev/null || true)
  case "$status" in
    Playing)
      chosen="$player"
      chosen_status="$status"
      break
      ;;
    Paused)
      if [[ -z "$paused_candidate" ]]; then
        paused_candidate="$player"
        paused_status="$status"
      fi
      ;;
  esac
done < <(playerctl -l 2>/dev/null)

if [[ -z "$chosen" ]]; then
  chosen="$paused_candidate"
  chosen_status="$paused_status"
fi

if [[ -z "$chosen" ]]; then
  jq -nc '{text:"", class:"empty", tooltip:"No media"}'
  exit 0
fi

artist=$(playerctl -p "$chosen" metadata artist 2>/dev/null || true)
title=$(playerctl -p "$chosen" metadata title 2>/dev/null || true)
album=$(playerctl -p "$chosen" metadata album 2>/dev/null || true)

if [[ -z "$artist" && -z "$title" ]]; then
  jq -nc '{text:"", class:"empty", tooltip:"No media"}'
  exit 0
fi

if [[ -n "$artist" && -n "$title" ]]; then
  label="$artist — $title"
elif [[ -n "$title" ]]; then
  label="$title"
else
  label="$artist"
fi

max=70
if ((${#label} > max)); then
  short="${label:0:max}…"
else
  short="$label"
fi

case "$chosen_status" in
  Playing) icon=""; class="playing" ;;
  Paused) icon="󰏤"; class="paused" ;;
  *) icon=""; class="unknown" ;;
esac

text="$icon $short"
tooltip="$chosen_status"
[[ -n "$artist" ]] && tooltip+=$'\n'"Artist: $artist"
[[ -n "$title" ]] && tooltip+=$'\n'"Title: $title"
[[ -n "$album" ]] && tooltip+=$'\n'"Album: $album"
tooltip+=$'\n'"Player: $chosen"

jq -nc --arg text "$text" --arg class "$class" --arg tooltip "$tooltip" \
  '{text:$text, class:$class, tooltip:$tooltip}'
