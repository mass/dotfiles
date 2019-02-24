# Color Variables
R="%s%b%u%F{red}"
G="%s%b%u%F{green}"
Y="%s%b%u%F{yellow}"
B="%s%b%u%F{blue}"
M="%s%b%u%F{magenta}"
N="%s%b%u%F{cyan}"
W="%s%b%u%F{white}"
C="%s%b%u%F{reset}"
SO="%S%B%u%F{cyan}"

# Left Side Prompt
PS1="${Y}["\
"${R}%n${Y}@${R}%m${Y}]"\
"%(2L,${Y} [${B}↓%L${Y}],)"\
"%(1j,${Y} [${B}☢%j${Y}],)"\
"${Y} [${G}%~${Y}]"\
"${R}"'$(git_prompt_string)'\
"${Y} %(!,#,|») "

# Right Side Prompt
RPS1="%(1?, ${Y}[${R}%?${Y}] ,)"\
"${Y}[${R}%*::%D${Y}]${C}"

# New Format for Color Variables
Y="%{$fg[yellow]%}"
R="%{$fg[red]%}"
G="%{$fg[green]%}"
B="%{$fg[blue]%}"
C="%{$reset_color%}"

# Git Prompt Symbols
GIT_PROMPT_SYMBOL=" "
GIT_PROMPT_PREFIX="${Y}[${C}"
GIT_PROMPT_SUFFIX="${Y}]${C}"
GIT_PROMPT_EQUAL="${B}‖${C}"
GIT_PROMPT_AHEAD="${R}↑NUM${C}"
GIT_PROMPT_BEHIND="${R}↓NUM${C}"
GIT_PROMPT_MERGING="${R}☭${C}"
GIT_PROMPT_REBASING="${R}♞${C}"
GIT_PROMPT_CHERRYPICKING="${R}©${C}"
GIT_PROMPT_BISECTING="${R}✂${C}"
GIT_PROMPT_STASHED="${R}☢${C}"
GIT_PROMPT_UNTRACKED="${R}●${C}"
GIT_PROMPT_MODIFIED="${Y}●${C}"
GIT_PROMPT_STAGED="${G}●${C}"
