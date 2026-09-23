#!/usr/bin/env bash
cd "$(dirname "$0")"

# Create a .config if necessary
if [[ ! -d ~/.config ]]; then
    mkdir ~/.config
fi

config_dir="$(pwd)"

# bash files
ln -sif $config_dir/bash_files/bash_aliases ~/.bash_aliases
ln -sif $config_dir/bash_files/bash_profile ~/.bash_profile
ln -sif $config_dir/bash_files/bashrc ~/.bashrc

# vim
ln -sif vim/.vimrc ~/.vimrc

# alacritty
if [[ -d ~/.config/alacritty ]]; then
    mv ~/.config/alacritty ~/.config/alacritty.old
fi
ln -sif alacritty/ ~/.config/alacritty

# tmux
ln -sif tmux/.tmux.conf ~/.tmux.conf
# Symlink the whole tmux config dir so all theme files are accessible.
# current.tmuxtheme is a relative symlink inside the dir managed by floppy-trigger.
if [[ -d ~/.config/tmux && ! -L ~/.config/tmux ]]; then
    mv ~/.config/tmux ~/.config/tmux.old
fi
ln -sif $config_dir/tmux/ ~/.config/tmux

# git
ln -sif git_files/gitconfig ~/.gitconfig
sudo ln -sif git_files/commit_w_jtag.sh /usr/bin/

# nvim
ln -sif nvim ~/.config/nvim

# starship
ln --symbolic --interactive --relative --force starship/starship.toml ~/.config/

# fish
if [[ -d ~/.config/fish ]]; then
    mv ~/.config/fish ~/.config/fish.old
fi

ln --symbolic --interactive --force --relative fish ~/.config/

# zellij
if [[ -d ~/.config/zellij && ! -L ~/.config/zellij ]]; then
    mv ~/.config/zellij ~/.config/zellij.old
fi
ln -sif $config_dir/zellij/ ~/.config/zellij

# eilmeldung
ln --symbolic --interactive --force --relative eilmeldung ~/.config/
