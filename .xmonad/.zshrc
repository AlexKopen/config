export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim
export BROWSER=brave

ZSH_THEME="random"
DISABLE_AUTO_UPDATE=true

plugins=(git npm)

source $ZSH/oh-my-zsh.sh

export PATH=/home/mopar/.fnm:$PATH
eval "`fnm env`"

alias r="ranger"
alias d="cd ~/Documents"
alias update="yes | sudo pacman -Syu && yay -Syu"
