#!/usr/bin/env bash

spaces=$(yabai -m query --spaces)

for idx in $(jq -r '.[] | select(.label != "") | .index' <<<"$spaces"); do
  yabai -m space "$idx" --label ""
done

n=1
for idx in $(jq -r '.[] | select(."is-native-fullscreen" | not) | .index' <<<"$spaces"); do
  yabai -m space "$idx" --label "s$n"
  n=$((n + 1))
done

sketchybar --trigger spaces_changed
