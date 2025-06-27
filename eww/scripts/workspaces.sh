#!/usr/bin/env bash

workspaces() {
  WORKSPACES=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
  seq 1 10 | jq -Mc --argjson windows "${WORKSPACES}" --slurp 'map({id: ., windows: ($windows[. | tostring]//0)})'
}

active_workspace() {
  hyprctl activeworkspace -j | jq -Mc '{id: .id, lastwindowtitle: .lastwindowtitle}'
}

run() {
  if [[ "$1" == "--active" ]]; then
    active_workspace
  else
    workspaces
  fi
}

run "$1"
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  run "$1"
done
