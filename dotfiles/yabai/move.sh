#!/bin/bash

dir=$1
here=$(dirname "$0")

win=$(yabai -m query --windows --window) || exit 0
id=$(jq '.id' <<<"$win")
fs=$(jq '."is-native-fullscreen"' <<<"$win")

[ "$fs" = false ] && yabai -m window --swap "$dir" 2>/dev/null && exit 0
case $dir in west | east) ;; *) exit 0 ;; esac

target=$("$here/neighbor_display.sh" "$(jq '.display' <<<"$win")" "$dir")
[ -z "$target" ] && exit 0

# native fullscreen spaces can't change display, so leave fullscreen, move, re-enter
if [ "$fs" = true ]; then
  yabai -m window "$id" --toggle native-fullscreen
  for _ in $(seq 30); do
    sleep 0.1
    [ "$(yabai -m query --windows --window "$id" | jq '."is-native-fullscreen"')" = false ] && break
  done
  sleep 0.5
fi

# land on the visible space, or the first regular one if the target shows a fullscreen app
space=$(yabai -m query --spaces --display "$target" |
  jq -r 'map(select(."is-native-fullscreen" | not)) | (map(select(."is-visible")) + .)[0].index')
yabai -m window "$id" --space "$space"
yabai -m window --focus "$id"

if [ "$fs" = true ]; then
  sleep 0.3
  yabai -m window "$id" --toggle native-fullscreen
fi
