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

if [[ "${TERM}" != tmux-* ]]; then
  # Remap some colors on the color palette to be less awful. This uses "Operating
  # System Controls" (OSC) control sequences to communicate to the terminal and
  # tell it to use a specific RGB color for the given color index. The color
  # string is as described in XParseColor() docs.
  # https://www.xfree86.org/4.8.0/ctlseqs.html
  printf '\e]4;4;rgb:0a/6e/d1\e\\'  # Blue
  printf '\e]4;12;rgb:0a/6e/d1\e\\' # Bright blue
  printf '\e]4;1;rgb:c5/0f/1f\e\\'  # Red
  printf '\e]4;9;rgb:c5/0f/1f\e\\'  # Bright red

  # Similar idea, but instead we map the "dynamic" colors.
  printf '\e]10;rgb:fc/ba/03\e\\' # Foreground
  printf '\e]11;rgb:18/18/18\e\\' # Background
  printf '\e]12;rgb:fc/ba/03\e\\' # Cursor
fi
