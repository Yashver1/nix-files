#!/bin/bash

yabai -m space --focus "$1" 2>/dev/null

space=$(yabai -m query --spaces --space "$1") || exit 0
[ "$(jq '.windows | length' <<<"$space")" -eq 0 ] || exit 0
[ "$(yabai -m query --windows | jq 'map(select(.app == "Finder")) | length')" -eq 0 ] || exit 0

# activate Finder so keyboard focus follows to an empty space
osascript -e 'tell application id "com.apple.finder" to activate'
