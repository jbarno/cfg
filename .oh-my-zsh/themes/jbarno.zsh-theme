local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )$reset_color%"
local venv_dir="basename "${VIRTUAL_ENV}""
NEWLINE=$'\n'
PROMPT='%{$fg[magenta]%}%T $fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)${NEWLINE}${ret_status} '
RPROMPT='$fg[white]%n@%m%{$reset_color%}%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"
