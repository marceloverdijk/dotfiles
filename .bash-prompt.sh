export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

source $DOTFILES_HOME/git/git-prompt.sh

YELLOW="\[\e[0;33m\]"
ORANGE="\[\e[1;31m\]"
RED="\[\e[0;31m\]"
MAGENTA="\[\e[0;35m\]"
VIOLET="\[\e[1;35m\]"
BLUE="\[\e[0;34m\]"
CYAN="\[\e[0;36m\]"
GREEN="\[\e[0;32m\]"
COLOREND="\[\e[00m\]"

prompt() {

  # get exit status (we need to this before any other external command is executed)

  if [[ $? -eq 0 ]]; then
    exit_status="\$ "
  else
    exit_status="${RED}\$${COLOREND} "
  fi

  # keep track of the prompt length (so we can make the cwd responsive)

  prompt_length=0

  # get user@hostname (we use variables here instead of \u and \h to calculate prompt lenght)

  user=$USER
  hostname=${HOSTNAME%%.*}

  prompt_length=$(( $prompt_length + ${#user} + 1 + ${#hostname} + 1 )) # + user + @ + hostname + space

  # get git branch

  git_branch=`__git_ps1 "%s"`

  if [[ $git_branch != "" ]]; then

    prompt_length=$(( $prompt_length + 1 + ${#git_branch} + 1 )) # + ( + git_brach + )

    if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working tree clean" ]]; then
      git_branch="${GREEN}($git_branch)${COLOREND}"
    else
      git_branch="${ORANGE}($git_branch)${COLOREND}"
    fi
  fi

  # get current working directory

  cwd_max_length=$((`tput cols` - $prompt_length - 1)) # terminal width - prompt_length - space
  cwd=`pwd`
  cwd_prefix=""
  if [[ $cwd =~ ^"$HOME"(/|$) ]]; then
    cwd_max_length=$(( $cwd_max_length - 1 )) # -1 because of cwd_prefix (~)
    cwd_prefix="~"
    cwd="${cwd#$HOME}" # remove home subpath
  fi
  if [[ ${#cwd} -gt $cwd_max_length ]]; then
    offset=$(( ${#cwd} - $cwd_max_length + 4 )) # -4 because of /...
    cwd="/...${cwd:$offset}"
  fi
  cwd=$cwd_prefix$cwd # prefix cwd with ~ if needed

  # and finally set ps1

  PS1="${BLUE}$user${COLOREND}@${VIOLET}$hostname${COLOREND} ${YELLOW}$cwd${COLOREND} $git_branch\n$exit_status"
}

PROMPT_COMMAND=prompt
