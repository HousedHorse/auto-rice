#!/usr/bin/bash

DEST=/tmp/testdir

# copy dotfiles
cp -r dotfiles /tmp/testdir
mv $DEST/dotfiles/.* $DEST
rm -rf $DEST/dotfiles

# make .scripts executable
chmod +x $DEST/.scripts/*
