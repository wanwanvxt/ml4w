#!/usr/bin/env bash

DEV_MODE=false
if [[ "$1" == "--dev" ]]; then
  DEV_MODE=true
  echo ":: This mode is for development purposes only."
fi

DEST_FOLDER="$HOME/.ml4w"
PACKAGES=(
  "git"
  "base-devel"
  "rsync"
)

_is_installed_package() {
  pacman -Q "$1" &>/dev/null
}

_is_command_exists() {
  command -v "$1" &>/dev/null
}

_confirm() {
  local question="$1"
  local default="${2,,}"
  local yn
  local prompt

  case "$default" in
    y) prompt=" [Y/n]: " ;;
    n) prompt=" [y/N]: " ;;
    *) prompt=" [y/n]: " ;;
  esac

  while true; do
    read -p "$question$prompt" yn
    yn=${yn,,}

    if [[ -z "$yn" ]];then
      yn="$default"
    fi

    case "$yn" in
      y) return 0 ;;
      n) return 1 ;;
      *) echo "Please answer [Y/y]es or [N/n]o." ;;
    esac
  done
}

cat <<"EOF"
         __   ____  __      __
  _____ |  | / |  |/  \    /  \
 /     \|  |/  ^  |\   \/\/   /
/  Y Y  |  |___    /\        /
\  |_|__|_____/|__|  \__/\  /
 \/ by Vũ Xuân Trường     \/
EOF
if ! _confirm "Do you want to start the setup now?" "y"; then
  echo ":: Setup canceled."
  exit
fi

if [[ ! -d "$DEST_FOLDER" ]]; then
  mkdir -p "$DEST_FOLDER"
  echo ":: '$DEST_FOLDER' folder created."
fi

# sync package databases
echo ":: Synchronizing package databases..."
sudo pacman -Sy
echo

# check and install required packages
echo ":: Checking for required packages are installed..."
need_to_install=()
for pkg in "${PACKAGES[@]}"; do
  if _is_installed_package $pkg; then
    echo ":: '$pkg' is already installed."
  else
    need_to_install+=("$pkg")
  fi
done
if [[ "${#need_to_install[@]}" -ne 0 ]]; then
  echo ":: Packages not installed:"
  printf "\t%s\n" "${need_to_install[@]}"
  sudo pacman -S "${need_to_install[@]}"
fi
echo ":: All required packages are installed."

# install yay
echo ":: This setup requires 'yay' to install AUR packages."
if _is_command_exists "yay"; then
  echo ":: 'yay' is already installed."
else
  git clone https://aur.archlinux.org/yay.git "$DEST_FOLDER/yay"
  cd "$DEST_FOLDER/yay"
  makepkg -si
  echo ":: 'yay' has been installed successfully."
fi

# clone ml4w repos
echo ":: Cloning 'ml4w' repository..."
if [[ -d "$DEST_FOLDER/ml4w" ]]; then
  rm -rf "$DEST_FOLDER/ml4w"
  echo ":: Old 'ml4w' folder removed."
fi
if $DEV_MODE; then
  rsync -a --exclude '.git' "$(pwd)/" "$DEST_FOLDER/ml4w"
else
  git clone --depth 1 https://github.com/wanwanvxt/ml4w.git "$DEST_FOLDER/ml4w"
fi
echo ":: 'ml4w' repository cloned successfully."

cd "$DEST_FOLDER/ml4w"
if _confirm "Are you using NVIDIA GPU?" "n"; then
  USE_NVIDIA=true
else
  USE_NVIDIA=false
fi
source ./setup/setup.sh
