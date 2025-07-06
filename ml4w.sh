#!/usr/bin/env bash

download_folder="$HOME/.ml4w"
packages=(
  "git"
  "base-devel"
  "rsync"
  "gum"
)

_is_installed_package() {
  pacman -Q "$1" &>/dev/null
}

_is_command_exists() {
  command -v "$1" &>/dev/null
}

cat <<"EOF"
         __   _____ __      __
  _____ |  | /  |  /  \    /  \
 /     \|  |/   ^  \__ \/\/   /
/  Y Y  \  |____    _/       /
\  |_|__/______/|__| \__/\  /
 \/ by Vũ Xuân Trường     \/
EOF
while true; do
  if $dev_mode; then
    read -p "Do you want to start the setup now (Development mode)? [Y/n]: " yn
  else
    read -p "Do you want to start the setup now? [Y/n]: " yn
  fi
  yn=${yn,,}

  case "$yn" in
    y|"") break ;;
    n)
      echo ":: Setup canceled."
      exit
      ;;
    *) echo "Please answer [Y/y]es or [N/n]o." ;;
  esac
done

if [[ ! -d "$download_folder" ]]; then
  mkdir -p "$download_folder"
  echo ":: '$download_folder' folder created."
fi

# sync package databases
# echo ":: Synchronizing package databases..."
sudo pacman -Sy
echo

# check and install required packages
echo ":: Checking for required packages are installed..."
need_to_install=()
for pkg in "${packages[@]}"; do
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
  git clone https://aur.archlinux.org/yay.git "$download_folder/yay"
  cd "$download_folder/yay"
  makepkg -si
  echo ":: 'yay' has been installed successfully."
fi

# clone ml4w repos
echo ":: Cloning 'ml4w' repository..."
if [[ -d "$download_folder/ml4w/.git" ]]; then
  echo ":: 'ml4w' already exists, pulling latest changes..."
  git -C "$download_folder/ml4w" pull --rebase
else
  git clone --depth 1 https://github.com/wanwanvxt/ml4w.git "$download_folder/ml4w"
fi
echo ":: 'ml4w' repository cloned successfully."

cd "$download_folder/ml4w"
source ./scripts/setup.sh
