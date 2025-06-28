#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -n "$1" ]]; then
  cp -a "$SCRIPT_DIR/$1" ~/.config/
else
  cp -a "$SCRIPT_DIR"/* ~/.config/
fi
