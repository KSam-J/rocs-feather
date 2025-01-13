#!/usr/bin/env bash
cd "$(dirname "$0")"

# Create a .config if necessary
if [[ ! -d ~/.config ]]; then
    mkdir ~/.config
fi

# bash files
ln -sif bash_files/bash_aliases ~/.bash_aliases
ln -sif bash_files/bash_profile ~/.bash_profile
ln -sif bash_files/bashrc ~/.bashrc

# vim
ln -sif vim/.vimrc ~/.vimrc

# alacritty
if [[ -d ~/.config/alacritty ]]; then
    mv ~/.config/alacritty ~/.config/alacritty.old
fi
ln -sif alacritty/ ~/.config/alacritty

# tmux
ln -sif tmux/.tmux.conf ~/.tmux.conf

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

