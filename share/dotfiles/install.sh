#!/usr/bin/env bash

user_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for dir in "$dotfiles_dir"/*/; do
  if [[ -f "$dir/install.sh" ]]; then
    echo ":: ml4w :: Installing configs from '$dir'..."
    source "$dir/install.sh"
    echo ":: ml4w :: Installed configs from '$dir'."
  fi
done
