#!/bin/bash

# Updates all files to the latest versions.

DOTDIR=$(pwd)
VIMDIR=$(pwd)/vim
BASHDIR=$(pwd)/bash
ZSHDIR=$(pwd)/zsh

cd $DOTDIR
git pull origin master
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule update

cd $VIMDIR
git pull origin master
git submodule update
git submodule foreach git pull origin master

cd $ZSHDIR
git pull origin master
git submodule update
git submodule foreach git pull origin master

cd $DOTDIR
