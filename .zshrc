export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim
export BROWSER=firefox

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
alias wipe="rm -f ~/.xmonad/xmonad-x86_64-linux && rm -f ~/.xmonad/xmonad.errors && rm -f ~/.xmonad/xmonad.hi && rm -f ~/.xmonad/xmonad.o"
alias update="wipe && yes | sudo pacman -Syu && yay -Syu"
