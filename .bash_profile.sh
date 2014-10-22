source ~/.dotfiles/git/.git-completion.sh
source ~/.dotfiles/git/.git-prompt.sh

export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
