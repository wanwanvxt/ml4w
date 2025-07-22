rsync -av --delete --exclude "/install.sh" "$dotfiles_dir/gtk/" "$user_config_dir/gtk-3.0/"
rsync -av --delete --exclude "/install.sh" "$dotfiles_dir/gtk/" "$user_config_dir/gtk-4.0/"
