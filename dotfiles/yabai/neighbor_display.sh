#!/bin/bash
# usage: neighbor_display.sh <display index> <west|east>

yabai -m query --displays | jq -r --argjson src "$1" --arg dir "$2" '
  (.[] | select(.index == $src) | .frame) as $f
  | if $dir == "east" then map(select(.frame.x >= $f.x + $f.w)) | sort_by(.frame.x)
    else map(select(.frame.x + .frame.w <= $f.x)) | sort_by(-.frame.x) end
  | .[0].index // empty'
