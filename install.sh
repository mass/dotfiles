#!/bin/bash

# Installs the configuration for zsh, vim, and more that @mass uses.

usage() {
  echo "Usage: ./install.sh [-b] [-z]" >&2
  echo "       -b  Install bash configuration" >&2
  echo "       -z  Install zsh configuration" >&2
  exit 1
}

# Parses input options
SHELL=""
while getopts "bz" opt; do
  case $opt in
    b)
      SHELL="BASH"
      ;;
    z)
      SHELL="ZSH"
      ;;
  esac
done

# No environment was set in the arguments
if [[ -z $SHELL ]]; then
  usage
fi

DOTDIR=$(pwd)
VIMDIR=$(pwd)/vim
BASHDIR=$(pwd)/bash
ZSHDIR=$(pwd)/zsh

# Installs vim
cd ~
ln -i -s $DOTDIR/vimrc .vimrc
cd $VIMDIR
git submodule update --init

# Installs redshift.conf
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
cd ~
ln -i -s $DOTDIR/redshift.conf .config/redshift.conf

# Installs .gitconfig
ln -i -s $DOTDIR/gitconfig .gitconfig
