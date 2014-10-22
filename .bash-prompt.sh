export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

reset='\033[0m'
red='\033[0;31m'
green='\033[0;32m'
magenta='\033[0;35'
bred='\033[1;31m'

# Status of last command (for prompt)
function __stat() {
    if [ $? -eq 0 ]; then
        echo -en "$green[v]$reset"
    else
        echo -en "$red[x]$reset"
    fi
}

# set up command prompt
function __prompt_command() {

    EXIT="$?" # capture the exit status of the last command
    PS1=""

    if [ $EXIT -eq 0 ]; then PS1+="\[$green\][v]\[$reset\] "; else PS1+="\[$red\][x]\[$reset\] "; fi
    PS1+="\[$bred\]\u\[$reset\]@\[$bred\]\h\[$reset\]"
    PS1+=":\[$brmagenta\]\w\[$reset\]"
    PS1+='$(__git_ps1 " (%s)")'
    PS1+="\$ "
}

#PS1=''
#PS1+='$(__stat) $reset'             # command status
#PS1+='$bred\u$reset@$bred\h$reset'  # user@hostname
#PS1+=':$magenta\w$reset'            # working dir
#PS1+='$(__git_ps1 " (%s)")'         # git
#PS1+='\$ '                          # $

#export PS1

PROMPT_COMMAND=__prompt_command
