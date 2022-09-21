#!/bin/bash

# bash files
ln -sir bash_files/bash_aliases ~/.bash_aliases
ln -sir bash_files/bash_profile ~/.bash_profile
ln -sir bash_files/bashrc ~/.bashrc

# vim
ln -sir vim/.vimrc ~/.vimrc

# alacritty
if [[ ! -d ~/.config/alacritty ]]; then
    mkdir ~/.config/alacritty
fi
ln -sir alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# tmux
ln -sir tmux/.tmux.conf ~/.tmux.conf

# git
ln -sir git_files/gitconfig ~/.gitconfig
sudo ln -sir git_files/commit_w_jtag.sh /usr/bin/

