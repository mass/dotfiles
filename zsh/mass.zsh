############################
# Custom ZSH Configuration #
#                          #
# Author: Andrew Mass      #
# Date:   2014-07-30       #
############################

# REF
# - `bindkey`: See currently active keybindings
# - <ESC-e>: Edit command line in text editor
# - `vared $VAR`: Edit $VAR variable
# - `=`: Simple calculator

# TODO
# - suffix and global aliases
# - https://geoff.greer.fm/lscolors/

# Color variables
BOLD="$(tput bold)"
RED=$BOLD"$(tput setaf 1)"
GREEN=$BOLD"$(tput setaf 2)"
YELLOW=$BOLD"$(tput setaf 3)"
BLUE=$BOLD"$(tput setaf 4)"
PURPLE=$BOLD"$(tput setaf 5)"
CYAN=$BOLD"$(tput setaf 6)"
WHITE=$BOLD"$(tput setaf 7)"
RESET="$(tput sgr0)"

# Shell options
setopt   AUTO_CD                       # Change to directory by entering as command
unsetopt BEEP                          # Don't beep on errors...
setopt   CHASE_LINKS                   # Resolve symlinks when changing dirs
setopt   NO_CHECK_JOBS                 # Exit without checking status of background jobs
setopt   NO_CLOBBER                    # Prevent redirection from truncating files (use >| to override)
unsetopt COMPLETE_ALIASES              # Expand aliases before completion
unsetopt CORRECT                       # Don't correct spelling of commands
unsetopt EXTENDED_GLOB                 # Disable extended glob patterns
unsetopt LIST_BEEP                     # Don't beep on ambiguous completion
setopt   NO_HUP                        # Don't send HUP to background jobs when exiting
setopt   SHORT_LOOPS                   # Allow short forms of for, repeat, select, if, and fucntions

# Completion options
# :completion:FUNCTION:COMPLETER:COMMAND-OR-MAGIC-CONTEXT:ARGUMENT:TAG
autoload -U compinit
compinit -C
unsetopt MENU_COMPLETE                 # Don't autoselect first completion entry
zstyle ':completion:*' menu select     # Nice menu tabular-formatted selection
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Use colors in completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on    # Cache completion results
zstyle ':completion:*' cache-path "${HOME}/.cache/zsh" # Completion cache location

# History options
setopt   APPEND_HISTORY                # Append to history file rather than replacing
setopt   EXTENDED_HISTORY              # Print timestamp with history entry
unsetopt HIST_BEEP                     # Don't beep...
setopt   HIST_EXPIRE_DUPS_FIRST        # When running out of space, first delete duplicat entries
unsetopt HIST_FIND_NO_DUPS             # Find duplicates of previously found lines
setopt   HIST_IGNORE_DUPS              # Don't save consequtive identical lines
setopt   HIST_VERIFY                   # Lets user edit history cmd before running
unsetopt INC_APPEND_HISTORY            # Disable when SHARE_HISTORY enabled
setopt   SHARE_HISTORY                 # Share history amongst all zsh sessions
export HISTFILE="${HOME}/.zsh_history" # History file location
export HISTSIZE=100000                 # Longer history
export HISTFILESIZE=100000             # Longer history file

# Edit command line in text editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# Command Aliases
alias a='alias'
alias m="man"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias more="less"
alias diff="diff -s"
alias grep='grep --color=auto'
alias tmuxa="tmux attach-session -t"
alias tmuxl="tmux list-sessions"
alias open="xdg-open"
alias g="git"
alias tigs="tig status"
alias tigy="tig stash"
alias ftail="tail -f -s 0.1 -n 1000"
alias mconv="/drive/development/scripts/mconv.sh"

# fasd Aliases
eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
alias fa="fasd -a"
alias fd="fasd -d"
alias ff="fasd -f"
alias fs="fasd -si"
alias fsd="fasd -sid"
alias fsf="fasd -sif"
alias fj="fasd_cd -d"
alias fjj="fasd_cd -d -i"
alias fv="fasd -f -e vim"
fasd_cd() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
  fi
}

# Util Aliases
alias copy="xclip -selection clipboard"
alias profileme="history | awk '{print \$2}' | awk 'BEGIN {FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 30 | sort -rn"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias shell='ps -p $$ -o comm='
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'
alias sensors="watch -d -n 0.5 sensors"
alias redreset="redshift -x"
alias sys-mon="tmuxinator start sys-mon"
alias sockets="ss -tuprs exclude close-wait exclude time-wait"
alias sockets-live="watch -n 1 \"date && echo && ss -tuprs exclude close-wait exclude time-wait\""

# ls aliases
alias sl="ls"
alias la="ls -A"
alias ll="ls -lh"
alias lla="ll -A"
alias l1="ls -1"
alias l1a="l1 -A"
alias l="ls"
alias ls='ls --color=auto'

# Configuration aliases
alias bashrc="vim ~/.bashrc"
alias zshrc="vim ~/.dotfiles/zsh/custom/mass.zsh"
alias vimrc="vim ~/.vimrc"
alias zshtheme="vim ~/.dotfiles/zsh/custom/mass.zsh-theme"
alias shload="exec zsh"

# Useful environment variables
export EDITOR=vim
export PATH="${PATH}:`ruby -e 'puts Gem.user_dir'`/bin"

# Colorize man output
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Randomness functions
flipcoin() {
  [[ $((RANDOM % 2)) == 0 ]] && echo TAILS || echo HEADS
}
rolldie() {
  if [[ -n "$1" ]]; then
    SIDES="$1"
  else
    SIDES=6
  fi
  echo $((RANDOM % $SIDES))
}
randgen() {
  if [[ $# -eq 0 ]]; then
    openssl rand -hex 32
  else
    openssl rand -hex $1 | cut -c1-$1
  fi
}

# Travels up N directories
up() {
  if [[ $# -eq 0 ]]; then
    local NUM=1
  else
    local NUM=$1
  fi

  local DIR=$PWD

  for ((i=0; i<NUM; i++)) do
    DIR=$DIR/..
  done

  cd $DIR
}

# Manual Package Update and Cleaning
pkupdate() {
  # Run everything as root
  sudo echo ""

  Time="$(date +%s)"
  echo -e "${GREEN}Starting Package Update${RESET}"
  echo -e "${GREEN}=======================${RESET}"

  if [[ $# -gt 0 ]]; then
    echo -e "${CYAN}Arguments: $@${RESET}"
  fi

  # Use apt-get if present
  local APT_GET_VERSION=$(apt-get --version 2> /dev/null)
  if [ "${APT_GET_VERSION}" ]; then
      echo -e "${GREEN}\nUsing apt-get!${RESET}"
      echo -e "${GREEN}--------------${RESET}"

      echo -e "${GREEN}\nUpdating Repositories${RESET}"
      sudo apt-get $@ update

      echo -e "${GREEN}\nUpdating Packages${RESET}"
      sudo apt-get $@ upgrade

      echo -e "${GREEN}\nUpdating Distribution Packages${RESET}"
      sudo apt-get $@ dist-upgrade

      echo -e "${GREEN}\nChecking and Repairing Dependencies${RESET}"
      sudo apt-get $@ check

      echo -e "${GREEN}\nRemoving Unnecessary Packages${RESET}"
      sudo apt-get $@ autoremove --purge

      echo -e "${GREEN}\nCleaning Package Download Files${RESET}"
      sudo apt-get $@ autoclean
      sudo apt-get $@ clean
  fi

  # Use pacman if present
  local PACMAN_VERSION=$(pacman --version 2> /dev/null)
  if [ "${PACMAN_VERSION}" ]; then
      echo -e "${GREEN}\nUsing pacman!${RESET}"
      echo -e "${GREEN}-------------${RESET}"

      echo -e "${GREEN}\nUpdating Package Databases${RESET}"
      sudo pacman -Syy $@

      echo -e "${GREEN}\nUpdating Packages${RESET}"
      sudo pacman -Suu --needed $@

      echo -e "${GREEN}\nRemove Unnecessary Packages${RESET}"
      local UP=$(pacman -Qtdq)
      if [ "${UP}" ]; then
          sudo bash -c "pacman -Qtdq | pacman -Rnssu -"
      fi

      echo -e "${GREEN}\nCleaning Caches${RESET}"
      sudo pacman -Scc $@ <<< Y <<< Y

      echo -e "${GREEN}\nCheck Database Consistency${RESET}"
      pacman -Dk

      echo -e "${GREEN}\nCheck Package Integrity${RESET}"
      sudo pacman -Qk --color=always | grep "warning: "

      echo -e "${GREEN}\nOptional Commands:${RESET}"
      echo -e "sudo pacman -Qkk      : More detailed package integrity checks"
      echo -e "sudo pacman-optimize  : Defragment package database files"
  fi

  local YAOURT_VERSION=$(yaourt --version 2> /dev/null)
  if [ "${YAOURT_VERSION}" ]; then
    echo -e "${GREEN}\nUsing yaourt!${RESET}"
    echo -e "${GREEN}-------------${RESET}"
    yaourt -Syu --aur
  fi

  Time="$(($(date +%s) - Time))"
  echo -e "${GREEN}\nPackage Update Complete. Time Elapsed: ${RED}${Time}s${RESET}"
}

# Remind me of common maitenance commands
remind() {
    echo -e "pkupdate            : Perform package maitenance"
    echo -e "systemctl --failed  : Check systemd failed units"
    echo -e "journalctl -xb -p 3 : Check systemd logs"
    echo -e "pacman -Qte         : Review manually installed, unrequired packages"
    echo -e "pacgraph            : Generate visual representation of packages"
}

# Directory usage stats
dstat() {
  local DIR=$(pwd)
  [ ! -z "$1" ] && DIR="$1"
  du $DIR -h -d 1 | sort -hr
}

# Print out the full range of 256 colors
print_colors() {
  printf "\x1b[30;47m" # Black foreground
  for i in {0..255}; do
    printf "\x1b[48;5;${i}m%3d " "${i}" # Color background
    if (( $i == 15 )) || (( $i > 15 )) && (( ($i-15) % 12 == 0 )); then
      echo
    fi
  done
  printf "\x1b[0m" # Reset
}

# Print horizontal rule
hr() {
  print ${(l:COLUMNS::=:)}
}
