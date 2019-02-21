#!/usr/bin/bash

git pull

# config files
TERMITERC=dotfiles/.config/termite/config
POLYBARRC=dotfiles/.config/polybar/config
I3RC=dotfiles/.config/i3/config
VIMRC=dotfiles/.vimrc
BASHRC=dotfiles/.bashrc
VIMFILES=dotfiles/.vim/*

# make directories if they don't exist
mkdir -p ~/.config/termite
mkdir -p ~/.config/polybar
mkdir -p ~/.config/i3
mkdir -p ~/.vim

# locations
TERMITE=

ls $VIMFILES
