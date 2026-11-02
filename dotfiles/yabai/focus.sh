#!/bin/bash

dir=$1
here=$(dirname "$0")

yabai -m window --focus "$dir" 2>/dev/null && exit 0

src=$(yabai -m query --windows --window 2>/dev/null | jq -r '.display // empty')
[ -z "$src" ] && src=$(yabai -m query --displays --display mouse | jq -r '.index')

target=$("$here/neighbor_display.sh" "$src" "$dir")
[ -z "$target" ] && exit 0

id=$(yabai -m query --windows --display "$target" |
  jq -r 'map(select(."is-visible" and (."is-minimized" | not))) | sort_by(."is-floating") | .[0].id // empty')

if [ -n "$id" ]; then
  yabai -m window --focus "$id"
else
  "$here/focus_space.sh" "$(yabai -m query --spaces --display "$target" | jq -r 'map(select(."is-visible"))[0].index')"
fi
