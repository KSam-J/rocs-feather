#!/bin/bash

# bash files
ln -sfr bash_files/bash_aliases ~/.bash_aliases
ln -sfr bash_files/bash_profile ~/.bash_profile
ln -sfr bash_files/bashrc ~/.bashrc

# vim
ln -sfr vim/.vimrc ~/.vimrc

# alacritty
if [[ ! -d ~/.config/alacritty ]]; then
    mkdir ~/.config/alacritty
fi
ln -sfr alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# tmux
ln -sfr tmux/.tmux.conf ~/.tmux.conf

# git
ln -sfr git_files/gitconfig ~/.gitconfig

