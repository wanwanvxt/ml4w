# Dotfiles

These are my personal dotfiles for Arch Linux — not everything, just the important stuff.

## Structure

Each subdirectory represents the configuration for a specific app (e.g. `hypr/`, `eww/`, etc).
Inside each subdirectory is a `.dotfile` that defines the destination path where the configuration files should be copied.

Example:
```
.
└── hypr/
    ├── .dotfile (Contains: ~/.config/hypr)
    ├── hyprland.conf
    └── ...
```

## How to use

1. Use the script to apply a specific config by name:

```bash
./apply.sh <config_dir>
```

2. Apply all configs

```bash
./apply.sh
```
