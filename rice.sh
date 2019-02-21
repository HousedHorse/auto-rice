#!/usr/bin/bash

DEST=$HOME

# copy dotfiles
cp -r dotfiles $DEST
cp -r $DEST/dotfiles/.* $DEST
rm -rf $DEST/dotfiles

# make .scripts executable
chmod +x $DEST/.scripts/*
