#!/bin/bash

# Installs @mass's configuration for zsh, bash, vim, and more.

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

# Installs .toprc
ln -i -s $DOTDIR/toprc ~/.toprc

# Replace remotes with read-only URLs for other users.
while getopts "oe" opt; do
  case $opt in
    o)
      cd $DOTDIR
      echo "Installing read-only remotes."
      sed -i "s/git@github.com:/git:\/\/github.com\//" .gitmodules
      ;;
    e)
      ON_EWS=true
      ;;
  esac
done

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
git remote add upstream git://github.com/avp/vimfiles.git
git fetch

# Fix configuration for EWS machines if -e was used
if [ "$ON_EWS" = true ]; then
  cd $DOTDIR
  echo "Installing EWS-compatible configuration."
  sed -i "s/set cryptmethod=blowfish//" ./vim/vimrc
  sed -i "s/git status -sb/git status -s/" ./zsh/custom/base.zsh
  sed -i "s/st = status -sb/st = status -s/" ./gitconfig
fi

# Update zsh
cd $ZSHDIR
git checkout master
git pull origin master
git submodule foreach git checkout master
git submodule foreach git pull origin master
git remote add upstream git://github.com/robbyrussell/oh-my-zsh.git
git fetch
