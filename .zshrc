export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim
export BROWSER=firefox

ZSH_THEME="random"
DISABLE_AUTO_UPDATE=true

plugins=(git npm)

source $ZSH/oh-my-zsh.sh

. "$HOME/.asdf/asdf.sh"

alias r="ranger"
alias d="cd ~/Documents"
alias update="rm -rf ~/.xmonad/build-x86_64-linux && rm -f ~/.xmonad/xmonad-x86_64-linux && rm -f ~/.xmonad/xmonad.errors && sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y"
alias a='function _cap() { git add .; npm run prettier; git commit -am "$1"; git push; }; _cap'
