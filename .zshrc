export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim
export BROWSER=brave

ZSH_THEME="random"
DISABLE_AUTO_UPDATE=true

plugins=(git npm)

source $ZSH/oh-my-zsh.sh

export PATH="/home/alex/.local/share/fnm:$PATH"
eval "`fnm env`"

alias r="ranger"
alias d="cd ~/Documents"
alias p="sudo pacman -S --needed"
alias y="yay"
alias update="yes | sudo pacman -Syu && yay -Syu"
