if [[ $use_nvidia != "true" || $use_nvidia != "false" ]]; then
  use_nvidia=$(gum confirm --default="no" "Using NVIDIA GPU?" && echo "true" || echo "false")
fi

rsync -av --delete \
  --exclude "install.sh" \
  --exclude "conf/custom.conf" \
  "$dotfiles_dir/hypr/" "$user_config_dir/hypr/"

if [[ ! -f "$user_config_dir/hypr/conf/custom.conf" ]]; then
  cp "$dotfiles_dir/hypr/conf/custom.conf" "$user_config_dir/hypr/conf/custom.conf"
fi

hyprland_conf="$user_config_dir/hypr/hyprland.conf"
if [[ -f "$hyprland_conf" ]]; then
  if [[ $use_nvidia == "true" ]]; then
    sed -i 's/^# \(source = .\/conf\/nvidia\.conf\)/\1/' "$hyprland_conf"
  else
    sed -i 's/^\(source = .\/conf\/nvidia\.conf\)/# \1/' "$hyprland_conf"
  fi
fi
