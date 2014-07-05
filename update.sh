#!/bin/bash

# Updates all files to the latest versions.

DOTDIR=$(pwd)
VIMDIR=$(pwd)/vim
ZSHDIR=$(pwd)/zsh

cd $DOTDIR
git checkout master
git pull origin master
git submodule update --rebase

cd $VIMDIR
git checkout master
git pull origin master
git pull upstream master
git submodule update --rebase
git submodule foreach git pull origin master

cd $ZSHDIR
git checkout master
git pull origin master
git pull upstream master
git submodule update --rebase
git submodule foreach git pull origin master

cd $DOTDIR
