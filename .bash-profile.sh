export DOTFILES_HOME=~/.dotfiles

export CLICOLOR=1
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="0;32"

alias ~="cd ~"
alias e="atom"
alias edit="atom"

source $DOTFILES_HOME/.bash-prompt.sh
source $DOTFILES_HOME/git/git-completion.bash
source $DOTFILES_HOME/gradle/gradle-completion.bash
source $DOTFILES_HOME/sdkman/sdkman-completion.bash
