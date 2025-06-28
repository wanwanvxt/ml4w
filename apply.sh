#!/usr/bin/env bash

set -x

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

apply_config() {
  local source_dir="$1"
  local dotfile_path="$source_dir/.dotfile"

  if [[ ! -f "$dotfile_path" ]]; then
    echo ".dotfile does not exist in '$source_dir'"
    return
  fi

  local dest_dir
  dest_dir=$(grep -m 1 -v '^[[:space:]]*$' "$dotfile_path")
  dest_dir="${dest_dir%/}"
  eval dest_dir="$dest_dir"

  if [[ -z "$dest_dir" ]]; then
    echo ".dotfile is empty"
    return
  fi

  mkdir -p "$dest_dir"
  rsync -a --exclude=".dotfile" "$source_dir/" "$dest_dir/"
  echo "Copied from '$source_dir' to '$dest_dir'"
}

if [[ -n "$1" ]]; then
  target_dir="$DOTFILES_DIR/$1"
  if [[ -d "$target_dir" ]]; then
    apply_config "$target_dir"
  else
    echo "'$1' does not exist"
    exit 1
  fi
else
  for dir in "$DOTFILES_DIR"/*/; do
    [[ -d "$dir" ]] && apply_config "$dir"
  done
fi
