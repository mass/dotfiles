#!/bin/bash

# Installs @mass's configuration for zsh, bash, vim, and more. 

DOTDIR=$(pwd)
VIMDIR=$(pwd)/vim
BASHDIR=$(pwd)/bash
ZSHDIR=$(pwd)/zsh

# Installs zshrc
ln -i -s $ZSHDIR/zshrc ~/.zshrc

# Installs bashrc
ln -i -s $BASHDIR/bashrc ~/.bashrc

# Installs vim
ln -i -s $DOTDIR/vimrc ~/.vimrc
ln -i -s $VIMDIR ~/.vim
cd $VIMDIR
rm vim
git submodule update --init

# Installs redshift.conf
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
ln -i -s $DOTDIR/redshift.conf ~/.config/redshift.conf

# Installs .gitconfig
ln -i -s $DOTDIR/gitconfig ~/.gitconfig
