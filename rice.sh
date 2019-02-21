#!/usr/bin/bash

DEST=$HOME

# copy dotfiles
cp -r dotfiles /tmp/testdir
mv $DEST/dotfiles/.* $DEST
rm -rf $DEST/dotfiles

# make .scripts executable
chmod +x $DEST/.scripts/*
