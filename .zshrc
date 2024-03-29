export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim
export BROWSER=brave

ZSH_THEME="random"
DISABLE_AUTO_UPDATE=true

plugins=(git npm)

source $ZSH/oh-my-zsh.sh

export PATH="/home/alex/.local/share/fnm:$PATH"
eval "`fnm env`"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

alias r="ranger"
alias d="cd ~/Documents"
alias p="sudo pacman -S --needed"
alias y="yay"
alias update="rm -rf ~/.xmonad/build-x86_64-linux && rm -f ~/.xmonad/xmonad-x86_64-linux && rm -f ~/.xmonad/xmonad.errors && yes | sudo pacman -Syu && yay -Syu"
alias lockRemove="sudo rm /var/lib/pacman/db.lck"
alias a='function _cap() { git add .; yarn run prettier; git commit -am "$1"; git push; }; _cap'
