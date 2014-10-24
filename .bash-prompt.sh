export GIT_PS1_SHOWCOLORHINTS=true

YELLOW="\[\e[0;33m\]"
ORANGE="\e[1;31m\]"
RED="\[\e[0;31m\]"
MAGENTA="\[\e[0;35m\]"
VIOLET="\e[1;35m\]"
BLUE="\[\e[0;34m\]"
CYAN="\[\e[0;36m\]"
GREEN="\[\e[0;32m\]"
COLOREND="\[\e[00m\]"

working_directory() {
  dir=`pwd`
  in_home=0
  if [[ `pwd` =~ ^"$HOME"(/|$) ]]; then
    dir="~${dir#$HOME}"
    in_home=1
  fi
  workingdir="$dir"
  # TODO make workingdir responsive
  echo -e "${YELLOW}$workingdir${COLOREND} "
}

parse_git_branch() {
  branch=`__git_ps1 "%s"`
  if [[ $branch != "" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working directory clean" ]]; then
      echo "(${GREEN}$branch${COLOREND}) "
    else
      echo "(${ORANGE}$branch${COLOREND}) "
    fi
  fi
}

prompt() {
  if [[ $? -eq 0 ]]; then
    exit_status="\$ "
  else
    exit_status="${RED}\$${COLOREND} "
  fi

  PS1="${BLUE}\u${COLOREND}@${VIOLET}\h${COLOREND} $(working_directory)$(parse_git_branch)\n$exit_status"
}

PROMPT_COMMAND=prompt
