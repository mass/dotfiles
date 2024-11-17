# Color Variables
R=$'%{\x1b[38;5;1m%}'
G=$'%{\x1b[38;5;2m%}'
Y=$'%{\x1b[38;5;3m%}'
B=$'%{\x1b[38;5;4m%}'
C=$'%{\x1b[0m%}'

# Left Side Prompt
PROMPT="${Y}["\
"${R}%n${Y}@${R}%M${Y}]"\
"%(1j, [${B}‽%j${Y}],)"\
" [${G}%~${Y}]"\
'$(git_prompt_string)'\
" ${Y}%(!,#,❯) ${C}"

# Right Side Prompt
RPROMPT="%(1?, ${Y}[${R}%?${Y}] ,)"\
"${Y}[${R}%*::%D${Y}]${C}"
