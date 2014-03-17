#!/bin/bash

# Installs @mass's configuration for zsh, bash, vim, and more.

# TODO:
#  -Set up upstream remotes for updating.
#  -Add cli flag for using read-only remotes (for other users)

DOTDIR=$(pwd)
VIMDIR=$(pwd)/vim
BASHDIR=$(pwd)/bash
ZSHDIR=$(pwd)/zsh

# Installs bashrc
ln -i -s $BASHDIR/bashrc ~/.bashrc

# Installs zshrc
ln -i -s $ZSHDIR/zshrc ~/.zshrc

# Installs vim
ln -i -s $VIMDIR/vimrc ~/.vimrc
if [ -h ~/.vim ]; then
  rm ~/.vim
fi
ln -i -s "$VIMDIR" ~/.vim

# Installs redshift.conf
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
ln -i -s $DOTDIR/redshift.conf ~/.config/redshift.conf

# Installs .gitconfig
ln -i -s $DOTDIR/gitconfig ~/.gitconfig

# Pulls down submodules
cd $DOTDIR
git submodule update --init
cd $VIMDIR
git submodule update --init

# Update vim
cd $VIMDIR
git checkout master
git pull origin master
git submodule foreach git checkout master
git submodule foreach git pull origin master

# Update zsh
cd $ZSHDIR
git checkout master
git pull origin master
