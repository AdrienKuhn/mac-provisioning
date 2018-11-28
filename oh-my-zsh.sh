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
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time user dir dir_writable vcs ssh virtualenv aws kubecontext)
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

echo "\033[0;34mDone! \033[0m"
