#!/bin/bash
set -e
GREEN="$(tput setaf 2)"
RESET="$(tput sgr0)"

# Updates all files to their correct versions in the repo.
echo "${GREEN}Updating main repo${RESET}"
git pull origin master

echo "${GREEN}Updating submodules recursively${RESET}"
git submodule update --init --recursive
