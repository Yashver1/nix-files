#!/bin/bash

FULLSCREEN_ICON=$(printf '\363\260\212\223')
MAX_SPACES=16

args=()
n=1
count=0
while read -r idx fs; do
  if [ "$fs" = true ]; then
    icon=$FULLSCREEN_ICON
  else
    icon=$n
    n=$((n + 1))
  fi
  args+=(--set "space.$idx" icon="$icon" drawing=on)
  count=$idx
done < <(yabai -m query --spaces | jq -r '.[] | "\(.index) \(."is-native-fullscreen")"')

for ((i = count + 1; i <= MAX_SPACES; i++)); do
  args+=(--set "space.$i" drawing=off)
done

sketchybar "${args[@]}"
