#!/usr/bin/env bash

localmode=$([[ $1 == "--local" ]] && echo "true" || echo "false")
echo_prefix=":: ml4w ::"
dist_dir="$HOME/.ml4w"
packages=(
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "noto-fonts-extra"
  "ttf-liberation"
  "papirus-icon-theme"

  "hyprland"
  "hyprpaper"
  "qt5-wayland"
  "qt6-wayland"
  "xdg-desktop-portal"
  "xdg-desktop-portal-gtk"
  "xdg-desktop-portal-hyprland"
  "xdg-user-dirs"
  "polkit"

  "networkmanager"
  "libnotify"
  "wireplumber"
  "playerctl"
  "brightnessctl"
  "bluez"
  "bluez-utils"
  "cliphist"
  "grim"
  "slurp"
  "bash-completion"
  "fastfetch"
  "jq"
  "awk"
  "eza"
  "ffmpeg"
  "7zip"
  "unrar"
  "rsync"
  "gum"
  "yt-dlp"

  "cmake"
  "ninja"
  "meson"
  "clang"
  "python-pip"
  "rustup"
  "odin"
  "go"
  "nodejs"
  "npm"
  "pnpm"

  "qt6ct"
  "kitty"
  "dolphin"
  "ark"
  "btop"
  "nvtop"
  "firefox"
  "obs-studio"
  "vlc"
  "vlc-plugins-all"
  "imagemagick"
  "fcitx5"
  "fcitx5-gtk"
  "fcitx5-qt"
  "fcitx5-bamboo"
  "fcitx5-configtool"
)
aur_packages=(
  "maplemono-ttf"
  "maplemono-nf"
  "ttf-phosphor-icons"
  "bibata-cursor-theme"

  "adwaita-qt5-git"
  "adwaita-qt6-git"

  "visual-studio-code-bin"
  "quickshell-git"
  "freedownloadmanager"
)

_check_command_exists() {
  command -v "$1" &>/dev/null
}

_install_packages() {
  for pkg in "$@"; do
    sudo pacman --noconfirm --needed -S "${need_to_install[@]}"
  done
}

_install_packages_with_yay() {
  for pkg in "$@"; do
    yay --noconfirm --needed -S "${need_to_install[@]}"
  done
}

_install_yay() {
  if _check_command_exists "yay"; then
    echo "$echo_prefix 'yay' is already installed."
    return
  fi

  git clone https://aur.archlinux.org/yay.git "$dist_dir/yay"
  cd "$dist_dir/yay"
  makepkg -si
  cd - &>/dev/null
}

_clone_ml4w_repo() {
  if [[ $localmode == "true" ]]; then
    echo "$echo_prefix Using local mode, copying files..."
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    rsync -av --exclude=".git/" "$script_dir/" "$dist_dir/ml4w/"
  else
    if [[ -d "$dist_dir/ml4w" ]]; then
      rm -rf "$dist_dir/ml4w"
      echo "$echo_prefix Removed old 'ml4w' directory."
    fi
    git clone --depth 1 https://github.com/wanwanvxt/ml4w.git "$dist_dir/ml4w"
  fi
}

# === MAIN SCRIPT ===

cat <<EOF
         ______
  __ _  / / / /_    __
 /  ' \/ /_  _/ |/|/ /
/_/_/_/_/ /_/ |__,__/ by Vũ Xuân Trường

EOF
while true; do
  if [[ $localmode == "true" ]] then
    read -p "$echo_prefix Start the setup now (Local mode)? [Y/n]: " yn
  else
    read -p "$echo_prefix Start the setup now? [Y/n]: " yn
  fi
  yn=${yn,,}

  case "$yn" in
    y|"") break ;;
    n) exit ;;
    *) echo "$echo_prefix Please answer [Y/y]es or [N/n]o." ;;
  esac
done

if [[ ! -d "$dist_dir" ]]; then
  mkdir -p "$dist_dir"
  echo "$echo_prefix Created '$dist_dir' directory."
fi

# sync and update
echo "$echo_prefix Synchronizing and updating installed packages..."
sudo pacman -Syu
echo

# install yay
echo "$echo_prefix This setup requires 'yay' to manage packages."
echo "$echo_prefix Checking for 'base-devel' and 'git' packages..."
_install_packages "base-devel" "git"
echo "$echo_prefix 'base-devel' and 'git' packages are installed."
_install_yay
echo "$echo_prefix 'yay' is installed."

# sync and update again
echo "$echo_prefix Synchronizing and updating installed packages again with 'yay'..."
yay
echo

# check and install required packages
echo "$echo_prefix Checking for required packages..."
_install_packages_with_yay "${packages[@]}" "${aur_packages[@]}"
echo "$echo_prefix All required packages are installed."

use_nvidia=$(gum confirm --default="no" "Using NVIDIA GPU?" && echo "true" || echo "false")
if [[ $use_nvidia == "true" ]]; then
  _install_packages_with_yay "nvidia-open" "nvidia-utils" "egl-wayland"
  sudo bash -c 'echo "nvidia-drm.modeset=1" > /etc/modprobe.d/nvidia-drm.conf'
  echo "$echo_prefix NVIDIA packages are installed and configured."
fi

# enable and start services
echo "$echo_prefix Enabling and starting required services..."
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now bluetooth.service
echo "$echo_prefix All required services are enabled and started."

# clone ml4w repos
echo "$echo_prefix Cloning 'ml4w' repository..."
_clone_ml4w_repo
echo "$echo_prefix 'ml4w' repository cloned successfully."

# setting up xdg user dirs
echo "$echo_prefix Setting up XDG user directories..."
xdg-user-dirs-update --force
echo "$echo_prefix XDG user directories are set up."

# install dotfiles
echo "$echo_prefix Installing dotfiles..."
source "$dist_dir/ml4w/share/dotfiles/install.sh"
echo "$echo_prefix Dotfiles installed successfully."

echo "$echo_prefix ALL DONE!"
echo "$echo_prefix Please restart system to apply changes."
