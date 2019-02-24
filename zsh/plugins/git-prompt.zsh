# Adapted from code found at <https://gist.github.com/1712320>.

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[red]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_EQUAL="%{$fg[blue]%}=%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_REBASING="%{$fg_bold[magenta]%}R%{$reset_color%}"
GIT_PROMPT_CHERRYPICKING="%{$fg_bold[magenta]%}C%{$reset_color%}"
GIT_PROMPT_BISECTING="%{$fg_bold[magenta]%}B%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"

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

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [ -n "$GIT_DIR" ] && [ -d "${GIT_DIR}/rebase-merge" ]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_REBASING
  fi

  if [ -n "$GIT_DIR" ] && [ -f "${GIT_DIR}/CHERRY_PICK_HEAD" ]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_CHERRYPICKING
  fi

  if [ -n "$GIT_DIR" ] && [ -f "${GIT_DIR}/BISECT_LOG" ]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_BISECTING
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
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$GIT_PROMPT_PREFIX%{$fg[blue]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX $(parse_git_state)"
}
