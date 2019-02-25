# Adapted from code found at <https://gist.github.com/1712320>.

setopt prompt_subst
autoload -Uz colors && colors

# Color Variables
R=$'%{\x1b[38;5;1m%}'
G=$'%{\x1b[38;5;2m%}'
Y=$'%{\x1b[38;5;3m%}'
B=$'%{\x1b[38;5;4m%}'
C=$'%{\x1b[0m%}'

# Git Prompt Symbols
GIT_PROMPT_PREFIX="${Y}["
GIT_PROMPT_SUFFIX="${Y}]"
GIT_PROMPT_EQUAL="${B}‖"
GIT_PROMPT_AHEAD="${R}↑NUM"
GIT_PROMPT_BEHIND="${R}↓NUM"
GIT_PROMPT_STASHED="${R}§"
GIT_PROMPT_UNTRACKED="${R}©"
GIT_PROMPT_MODIFIED="${Y}©"
GIT_PROMPT_STAGED="${G}©"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
parse_git_state() {

  # Compose this value via multiple conditional appends.
  local GIT_STATE=""
  local EQUAL="1"

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    EQUAL=""
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    EQUAL=""
  fi

  if [ "$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null)" ]; then
    if [ "$EQUAL" ]; then
      GIT_STATE=${GIT_STATE}${GIT_PROMPT_EQUAL}
    fi
  fi

  if [[ -n $(git stash list 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STASHED
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi

  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -z "$git_where" ] && return
  echo " ${GIT_PROMPT_PREFIX}${B}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX $(parse_git_state)${C}"
}
