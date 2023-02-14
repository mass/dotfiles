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

### Options ####################################################################

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
autoload -Uz compinit
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
export HISTFILE=~/.zsh_history         # History file location
export HISTSIZE=200000                 # Longer history
export HISTFILESIZE=200000             # Longer history
export SAVEHIST=200000                 # Longer history

# Edit command line in text editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

### Variables ##################################################################

# PATH stuff
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}
pathadd "${HOME}/opt/bin"
if hash ruby 2>/dev/null; then
  pathadd "`ruby -e 'puts Gem.user_dir'`/bin"
fi

# Useful environment variables
export EDITOR=vim

# Color variables
RST=$'\x1b[0m'
BLD=$'\x1b[1m'
UND=$'\x1b[4m'
REV=$'\x1b[7m'
GRN=$'\x1b[38;5;2m'
CYN=$'\x1b[38;5;6m'
RED=$'\x1b[38;5;9m'
BLU=$'\x1b[38;5;33m'
LGY=$'\x1b[38;5;248m'

# Colorize man output
export LESS_TERMCAP_mb=$REV$RED        # Unused
export LESS_TERMCAP_md=$BLD$BLU        # Headers, keywords, etc
export LESS_TERMCAP_so=$REV$LGY        # Bottom pager line
export LESS_TERMCAP_us=$BLD$RED        # Underlined (more keywords)
export LESS_TERMCAP_me=$RST            # End modes
export LESS_TERMCAP_se=$RST            # End standout
export LESS_TERMCAP_ue=$RST            # End underline

### Aliases ####################################################################

# Common command aliases
alias a='alias'
alias m="man"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias more="less"
alias diff="diff -s"
alias grep='grep --color=auto'
alias ftail="tail -F -s 0.25 -n 1000"
alias ipc="ip -c"

# Util aliases
alias g="git"
alias tmuxa="tmux attach-session -t"
alias tmuxl="tmux list-sessions"
alias tigs="tig status"
alias tigy="tig stash"
alias mconv="/scratch/development/scripts/mconv.sh"
alias mconv-tv="/scratch/development/scripts/mconv-tv.sh"
alias sensors-live="watch -d -n 0.5 sensors"
alias sys-mon="tmuxinator start sys-mon"
alias sockets="ss -4tuapns exclude close-wait exclude time-wait"
alias sockets-full="ss -4tuapnsoemi --tos --cgroup exclude close-wait exclude time-wait"
alias sockets-live="watch -n 1 \"date && echo && ss -tuprs exclude close-wait exclude time-wait\""

# ls aliases
alias la="ls -A"
alias ll="ls -lh"
alias lla="ll -A"
alias llv="ls -lhv"
alias llav="llv -A"
alias l1="ls -1"
alias l1a="l1 -A"
alias l1v="ls -1v"
alias l1av="l1v -A"
alias ls='ls --color=auto --group-directories-first'

# Configuration aliases
alias shload="exec zsh"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.dotfiles/zsh/mass.zsh"
alias zshth="vim ~/.dotfiles/zsh/mass.zsh-theme"
alias bashrc="vim ~/.bashrc"

# fasd aliases
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

# cd Aliases
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

### Utility Functions ##########################################################

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

# Directory usage stats
dstat() {
  local DIR=$(pwd)
  [ ! -z "$1" ] && DIR="$1"
  du $DIR -h -d 1 | sort -hr
}

# Print out the full range of 256 colors
print_colors() {
  printf "\x1b[0m" # Reset
  printf "\nBackground\n"
  printf "\x1b[30;47m" # Black foreground
  for i in {0..255}; do
    printf "\x1b[48;5;${i}m %3d " "${i}" # Color background
    ((( $i == 7 )) || (( $i == 15)) || ((( $i > 15 )) && (( ($i-15) % 12 == 0)))) && echo
  done

  printf "\x1b[0m" # Reset
  printf "\nRegular Foreground\n"
  printf "\x1b[48;5;0m" # Black background
  for i in {0..255}; do
    printf "\x1b[38;5;${i}m %3d " "${i}" # Color background
    ((( $i == 7 )) || (( $i == 15)) || ((( $i > 15 )) && (( ($i-15) % 12 == 0)))) && echo
  done

  printf "\x1b[0m" # Reset
  printf "\nBold Foreground\n"
  printf "\x1b[48;5;0m" # Black background
  for i in {0..255}; do
    printf "\x1b[1m\x1b[38;5;${i}m %3d " "${i}" # Color background
    ((( $i == 7 )) || (( $i == 15)) || ((( $i > 15 )) && (( ($i-15) % 12 == 0)))) && echo
  done

  printf "\x1b[0m" # Reset
}

# Print horizontal rule
hr() {
  print ${(l:COLUMNS::=:)}
}

# Use tree command in interactive mode
ltree() {
  tree $@ | less
}

# Use ffmpeg to detect interlaced media
ffidet() {
  ffmpeg -analyzeduration 2147483647 -probesize 2147483647 -filter:v idet -frames:v 1000 -an -f rawvideo -y /dev/null -i "$1" 2>&1 | grep 'idet'
}

# Use ffprobe to output media information in JSON format
ffjson() {
  ffprobe -analyzeduration 2147483647 -probesize 2147483647 -show_streams -show_format -print_format json -pretty "$1" | jq .
}

# Upload files in a standardized way using the s3 CLI
s3s() {
  aws s3 cp $1 $2 --storage-class STANDARD --metadata "md5=$(md5sum $1 | cut -f1 -d' ')"
}
s3g() {
  aws s3 cp $1 $2 --storage-class GLACIER --metadata "md5=$(md5sum $1 | cut -f1 -d' ')"
}

### OS Functions ###############################################################

# Remind me of common maitenance commands
remind() {
    echo -e "pkupdate            : Perform package maitenance"
    echo -e "systemctl --failed  : Check systemd failed units"
    echo -e "journalctl -xb -p 3 : Check systemd logs"
    echo -e "pacman -Qtt         : Review all packages not explicitly required"
    echo -e "pacgraph            : Generate visual representation of packages"
}

# Manual Package Update and Cleaning
pkupdate() {
  # Run everything as root
  sudo echo ""

  Time="$(date +%s)"
  echo -e "${GRN}Starting Package Update${RST}"
  echo -e "${GRN}=======================${RST}"

  if [[ $# -gt 0 ]]; then
    echo -e "${BLD}${CYN}Arguments: $@${RST}"
  fi

  # Use apt-get if present
  local APT_GET_VERSION=$(apt-get --version 2> /dev/null)
  if [ "${APT_GET_VERSION}" ]; then
      echo -e "${GRN}\nUsing apt-get!${RST}"
      echo -e "${GRN}--------------${RST}"

      echo -e "${GRN}\nUpdating Repositories${RST}"
      sudo apt-get $@ update

      echo -e "${GRN}\nUpdating Packages${RST}"
      sudo apt-get $@ upgrade

      echo -e "${GRN}\nUpdating Distribution Packages${RST}"
      sudo apt-get $@ dist-upgrade

      echo -e "${GRN}\nChecking and Repairing Dependencies${RST}"
      sudo apt-get $@ check

      echo -e "${GRN}\nRemoving Unnecessary Packages${RST}"
      sudo apt-get $@ autoremove --purge

      echo -e "${GRN}\nCleaning Package Download Files${RST}"
      sudo apt-get $@ autoclean
      sudo apt-get $@ clean
  fi

  # Use pacman if present
  local PACMAN_VERSION=$(pacman --version 2> /dev/null)
  if [ "${PACMAN_VERSION}" ]; then
      echo -e "${GRN}\nUsing pacman!${RST}"
      echo -e "${GRN}-------------${RST}"

      echo -e "${GRN}\nUpdating Package Databases${RST}"
      sudo pacman -Syy $@

      echo -e "${GRN}\nUpdating File Databases${RST}"
      sudo pacman -Fyy $@

      echo -e "${GRN}\nUpdating Keyring${RST}"
      sudo pacman -S --needed archlinux-keyring $@

      echo -e "${GRN}\nUpdating Packages${RST}"
      sudo pacman -Suu --needed $@

      echo -e "${GRN}\nRemove Unnecessary Packages${RST}"
      local UP=$(pacman -Qtdq)
      if [ "${UP}" ]; then
          sudo bash -c "pacman -Qtdq | pacman -Rnsu -"
      fi

      echo -e "${GRN}\nCleaning Caches${RST}"
      sudo pacman -Scc $@ <<< Y <<< Y

      echo -e "${GRN}\nCheck Database Consistency${RST}"
      pacman -Dk

      echo -e "${GRN}\nCheck Package Integrity${RST}"
      sudo pacman -Qk --color=always | grep "warning: "

      echo -e "${GRN}\nOptional Commands:${RST}"
      echo -e "sudo pacman -Qkk      : More detailed package integrity checks"
      echo -e "sudo pacman-optimize  : Defragment package database files"
  fi

  Time="$(($(date +%s) - Time))"
  echo -e "${GRN}\nPackage Update Complete. Time Elapsed: ${BLD}${RED}${Time}s${RST}"
}

# Manual Package Cleaning
pkclean() {
  # Run everything as root
  sudo echo ""

  Time="$(date +%s)"
  echo -e "${GRN}Starting Package Clean${RST}"
  echo -e "${GRN}======================${RST}"

  if [[ $# -gt 0 ]]; then
    echo -e "${BLD}${CYN}Arguments: $@${RST}"
  fi

  # Use pacman if present
  local PACMAN_VERSION=$(pacman --version 2> /dev/null)
  if [ "${PACMAN_VERSION}" ]; then
      echo -e "${GRN}\nUsing pacman!${RST}"
      echo -e "${GRN}-------------${RST}"

      echo -e "${GRN}\nRemove Unnecessary Packages${RST}"
      local UP=$(pacman -Qtdq)
      if [ "${UP}" ]; then
          sudo bash -c "pacman -Qtdq | pacman -Rnssu -"
      fi

      echo -e "${GRN}\nCleaning Caches${RST}"
      sudo pacman -Scc $@ <<< Y <<< Y
  fi

  Time="$(($(date +%s) - Time))"
  echo -e "${GRN}\nPackage Clean Complete. Time Elapsed: ${BLD}${RED}${Time}s${RST}"
}
