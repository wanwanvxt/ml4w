#!/usr/bin/env bash

workspaces() {
  local workspaces_json=$(hyprctl workspaces -j)
  local active_id=$(hyprctl activeworkspace -j | jq -r '.id')

  local workspaces=$(echo "$workspaces_json" | jq 'map({key: (.id | tostring), value: .}) | from_entries')

  seq 1 10 | jq -Mc --argjson map "$workspaces" --argjson active_id "$active_id" --slurp '
    map(
      ($map[. | tostring] // {
        id: .,
        name: (. | tostring),
        monitor: null,
        monitorID: 0,
        windows: 0,
        hasfullscreen: false,
        lastwindow: null,
        lastwindowtitle: null,
        ispersistent: false
      }) + {active: (. == $active_id)}
    )
  '
}

workspaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  workspaces
done
