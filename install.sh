#!/bin/bash
set -e
GREEN="$(tput setaf 2)"
RESET="$(tput sgr0)"

# Installs @mass's configuration for zsh, bash, vim, and more.

DOTDIR=$(pwd)
VIMDIR=$(pwd)/vim
BASHDIR=$(pwd)/bash
ZSHDIR=$(pwd)/zsh

# Installs bashrc, zshrc
echo "${GREEN}Installing bashrc, zshrc${RESET}"
ln -i -s $BASHDIR/bashrc ~/.bashrc
ln -i -s $ZSHDIR/zshrc ~/.zshrc

# Installs vim
echo "${GREEN}Installing vim${RESET}"
ln -i -s $VIMDIR/vimrc.vim ~/.vimrc
if [ -h ~/.vim ]; then
  rm ~/.vim
fi
ln -i -s "$VIMDIR" ~/.vim

# Installs redshift.conf, .gitconfig, .toprc, .tmux.conf
echo "${GREEN}Installing config files${RESET}"
if [ ! -d ~/.config ]; then
  mkdir ~/.config
fi
ln -i -s $DOTDIR/redshift.conf ~/.config/redshift.conf
ln -i -s $DOTDIR/gitconfig ~/.gitconfig
ln -i -s $DOTDIR/toprc ~/.toprc
ln -i -s $DOTDIR/tmux.conf ~/.tmux.conf

# Get command line options
while getopts "oe" opt; do
  case $opt in
    o)
      # Replace remotes with read-only URLs for other users.
      cd $DOTDIR
      echo "${GREEN}Replace with read-only remotes${RESET}"
      sed -i '' "s/git@github.com:/git:\/\/github.com\//" .gitmodules
      ;;
    e)
      ON_EWS=true
      ;;
  esac
done

# Pulls down submodules recursively
echo "${GREEN}Pull down submodules recursively${RESET}"
git submodule update --init --recursive

# Fix vim configuration for EWS machines if -e was used
cd $VIMDIR
if [ "$ON_EWS" = true ]; then
  cd $DOTDIR
  echo "${GREEN}Installing EWS-compatible configuration${RESET}"
  sed -i "s/set cryptmethod=blowfish//" ./vim/vimrc.vim
  sed -i "s/git status -sb/git status -s/" ./zsh/custom/base.zsh
  sed -i "s/st = status -sb/st = status -s/" ./gitconfig
fi

