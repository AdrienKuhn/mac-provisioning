#!/bin/bash
set -e

# oh-my-zsh
echo "\033[0;34mInstalling oh-my-zsh \033[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Powerline, see https://gist.github.com/kevin-smets/8568070
echo "\033[0;34mInstalling and configuring Powerline \033[0m"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

sed -i 's/ZSH_THEME=".*/ZSH_THEME="powerlevel9k\/powerlevel9k"/g' ~/.zshrc
sed -i '/ZSH_THEME="/i \
# Powerlevel9k mode should be set before ZSH theme\
POWERLEVEL9K_MODE="nerdfont-complete"\
' ~/.zshrc

if  ! grep -q "POWERLEVEL9K configuration" ~/.zshrc; then
  cat >> ~/.zshrc <<- EOM
##
# POWERLEVEL9K configuration
##

# Custom segements for powerlevel9k
# See https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time user dir dir_writable vcs ssh virtualenv aws)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# Advanced "vcs" color customization
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='220' # Yellow
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='003' # Orange

# "Virtualenv" color customization
POWERLEVEL9K_VIRTUALENV_BACKGROUND='001' # red
EOM
else
  echo "\033[0;31mPowerlevel is already configured ? \033[0m"
fi

echo "\033[0;31mYou have to manually select the Hack Nerd Font in your iTerm2 profile\033[0m"

# Custom ZSH config

if ! grep -q "Custom shell configuration" ~/.zshrc; then
  cat >> ~/.zshrc <<- EOM

##
# Custom shell configuration
##

# Fix gettext
export PATH="/usr/local/opt/gettext/bin:$PATH"

# The Fuck
eval $(thefuck --alias)

# SSH
alias sshc='cat ~/.ssh/config'
alias sshk='ssh-add ~/.ssh/id_ed25519'

# GPG Sign
export GPG_TTY=$(tty)

# PostgreSQL 9.6
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# Pyenv
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
#export PATH="$(pyenv root)/shims:$PATH"

# Verbose
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# git
alias gd='git diff'
alias gs='git status'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gap='git add -p'
alias glh='gl | head -n 5'
alias gds='git diff --staged'
alias gca='git commit --amend -C HEAD'

# Secure delete
alias srm='srm -i -C -vvvv' # Interactive, Royal Canadian Mounted Police compliant 3-pass overwrite, verbose

# Miscellaneous
alias ts='date +%s'
alias weather='curl -4 "http://wttr.in/Montreal?m"'

# start terminal with timestamps
#if [ $TERM_PROGRAM = 'iTerm.app' ]; then
#  osascript -e 'tell application "System Events" to keystroke "e" using {command down, shift down}'
#fi

# Prints external IP address
function ip() {
  curl ifconfig.co
}

# Fetches a bogus file, printing the current download transfer speed
function speedtest() {
  wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip
}

# Get size of directories in current dir
function size_dirs() {
    for d in * ; do
        echo "$d:" $(du -ch "$d" 2>/dev/null | tail -1)
    done
}

# Search for string recursively in current dir
function cgrep() {
    ggrep --exclude-dir .git -InHir "$*" ./* 2>/dev/null
}

# docker clean images
docker_clean() {
    docker rmi --force $(docker images -aq --filter=dangling=true)
    docker images -a \
        | grep '^<none>' \
        | tr -s ' ' \
        | cut -d' ' -f 3 \
        | xargs docker rmi
    docker network prune
    docker volume prune
}
EOM

  fi

echo "\033[0;34mDone! \033[0m"
