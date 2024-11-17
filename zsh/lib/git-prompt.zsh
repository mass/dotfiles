# Adapted from code found at <https://gist.github.com/1712320>.

setopt prompt_subst
autoload -Uz colors && colors

# Color Variables
Y=$'%{\x1b[38;5;3m%}'
B=$'%{\x1b[38;5;4m%}'
C=$'%{\x1b[0m%}'

# Git Prompt Symbols
GIT_PROMPT_PREFIX="${Y}["
GIT_PROMPT_SUFFIX="${Y}]"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -z "$git_where" ] && return
  echo " ${GIT_PROMPT_PREFIX}${B}{${git_where#(refs/heads/|tags/)}}$GIT_PROMPT_SUFFIX${C}"
}
