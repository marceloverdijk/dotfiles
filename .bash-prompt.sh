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
  max_length=$(expr `tput cols` - 40)
  dir=`pwd`
  if [[ `pwd` =~ ^"$HOME"(/|$) ]]; then
    dir="~${dir#$HOME}"
  fi
  if [[ $max_length -lt 30 ]]; then
    cwd=${PWD##*/}
  elif [[ $max_length -gt ${#dir} ]]; then
    cwd=$dir
  else
    # see http://stackoverflow.com/questions/26554713/how-to-truncate-working-directory-in-prompt-to-show-first-and-last-folder
    # cwd=`pwd | awk -F/ -v "n=$(tput cols)" -v "h=^$HOME" '{sub(h,"~");n=n-40;b=$1"/"$2} length($0)<=n || NF==3 {print;next;} NF>3{b=b"/../"; e=$NF; n-=length(b $NF); for (i=NF-1;i>3 && n>length($i)+1;i--) e=$i"/"e;} {print b e;}'`

    while IFS='/' read -ra subdirs; do
      length=${#subdirs[@]}

      # refactor below
      for (( i=${length}; i>0; i-- )); do
        if [[ $i == $length && $i != 1 ]]; then
          cwd="/${subdirs[$i-1]}"
        elif [[ $i == 1 ]]; then
          if [[ ${subdirs[$i-1]} == "~" ]]; then
            cwd="~$cwd"
          else
            cwd="/${subdirs[$i-1]}$cwd"
          fi
        else
          cwd="/${subdirs[$i-1]:0:1}$cwd"
        fi
      done
      # refactor below end

    done <<< "$dir"
  fi
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
