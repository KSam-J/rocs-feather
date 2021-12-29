#!/bin/bash

# bash files
ln -sf bash_files/bash_aliases ~/.bash_aliases
ln -sf bash_files/bash_profile ~/.bash_profile
ln -sf bash_files/bashrc ~/.bashrc

# vim
ln -sf vim/.vimrc ~/.vimrc

# alacritty
if [[ ! -d ~/.config/alacritty ]]; then
    mkdir ~/.config/alacritty
fi
ln -sf alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# tmux
ln -sf tmux/.tmux.conf ~/.tmux.conf
