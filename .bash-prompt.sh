export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh

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
  # see http://stackoverflow.com/questions/26554713/how-to-truncate-working-directory-in-prompt-to-show-first-and-last-folder
  cwd=`pwd | awk -F/ -v "n=$(tput cols)" -v "h=^$HOME" '{sub(h,"~");n=0.7*n;b=$1"/"$2} length($0)<=n || NF==3 {print;next;} NF>3{b=b"/../"; e=$NF; n-=length(b $NF); for (i=NF-1;i>3 && n>length($i)+1;i--) e=$i"/"e;} {print b e;}'`

  # dir=`pwd`
  # if [[ `pwd` =~ ^"$HOME"(/|$) ]]; then
  #   dir="~${dir#$HOME}"
  # fi
  # cwd=""
  # if [[ $dir == "/" ]]; then
  #   cwd+="/"
  # fi
  #
  # while IFS='/' read -ra subdirs; do
  #   for subdir in "${subdirs[@]}"; do
  #     if [[ $subdir != "~" ]]; then
  #       cwd+="/"
  #     fi
  #     cwd+=$subdir
  #   done
  # done <<< "$dir"



  # for subdir in $(echo $dir | tr "/" "\n"); do
  #   if [[ $subdir != "~" ]]; then
  #     cwd+="/"
  #   fi
  #   cwd+=${subdir:0:1}
  # done
  # cwd+=${subdir:1}
  echo "${YELLOW}$cwd${COLOREND} "
}

parse_git_branch() {
  branch=`__git_ps1 "%s"`
  if [[ $branch != "" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working directory clean" ]]; then
      echo "${GREEN}($branch)${COLOREND} "
    else
      echo "${ORANGE}($branch)${COLOREND} "
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
