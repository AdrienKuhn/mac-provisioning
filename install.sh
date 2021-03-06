#!/bin/bash
set -e

if ! hash brew; then
  echo "\033[0;34mInstalling Homebrew \033[0m"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if hash brew; then
  # Update first
  echo "\033[0;34mUpdating Homebrew \033[0m"
  brew update
  brew upgrade

  for BREWFILE in "$@"
  do
    echo "\033[0;34mInstalling $BREWFILE profile \033[0m"
    brew bundle install --file="./profiles/$BREWFILE.Brewfile"
  done

  ##
  # Postinstall
  ##

  # If thefuck is installed but not enabled, enable it
  if brew list | grep thefuck > /dev/null; then
    # zshrc
    if [ -f ~/.zshrc ] && ! grep -q "eval $(thefuck --alias)" ~/.zshrc; then
      cat >> ~/.zshrc <<- EOM

# The Fuck
eval $(thefuck --alias)
EOM
    fi

    # bashrc
    if [ -f ~/.bashrc ] && ! grep -q "eval $(thefuck --alias)" ~/.bashrc; then
      cat >> ~/.bashrc <<- EOM

# The Fuck
eval $(thefuck --alias)
EOM
    fi

    # bash_profile
    if [ -f ~/.bash_profile ] && ! grep -q "eval $(thefuck --alias)" ~/.bash_profile; then
      cat >> ~/.bash_profile <<- EOM

# The Fuck
eval $(thefuck --alias)
EOM
    fi

  fi

  # If pinentry-mac is installed but not enabled, enable it
  if brew list | grep pinentry-mac > /dev/null; then
    if ! grep -q "pinentry-program" ~/.gnupg/gpg-agent.conf; then
      cat >> ~/.gnupg/gpg-agent.conf <<- EOM
# Connects gpg-agent to the OSX keychain via the brew-installed$
# pinentry program from GPGtools. This is the OSX 'magic sauce',$
# allowing the gpg key's passphrase to be stored in the login$
# keychain, enabling automatic key signing.$
pinentry-program /usr/local/bin/pinentry-mac
EOM
    fi
  fi

  echo "\033[0;34mDone! \033[0m"
else
  echo "\033[0;31mHomebrew is not installed! \033[0m"
fi
