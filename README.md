# Mac provisioning scripts

## Profiles

### Applications

#### Work profile
- alfred
- aria2
- atom
- awscli
- bash
- bash-completion
- cheat
- chromedriver
- clocker
- dnsmasq
- firefox
- firefox-developer-edition
- font-hack-nerd-font
- gettext
- git
- gnupg
- google-chrome
- gpg-agent
- grep
- htop
- httpie
- iterm2
- jetbrains-toolbox
- jq
- khell/srm/srm
- libxmlsec1
- mycli
- mysql
- n
- nmap
- osxfuse
- pgcli
- postgresql@9.6
- postman
- psequel
- pyenv-virtualenv
- sequel-pro
- slack
- sonar-scanner
- thefuck
- tunnelblick
- veracrypt
- wget
- yarn
- zsh

#### Personal profile
- aerial
- alfred
- aria2
- atom
- bitbar
- canary
- castbridge
- cheat
- clocker
- firefox
- firefox-developer-edition
- font-hack-nerd-font
- git
- gnupg
- google-chrome
- gpg-agent
- grep
- htop
- httpie
- iterm2
- jetbrains-toolbox
- jq
- krita
- macpass
- n
- nmap
- nordvpn
- osxfuse
- postman
- sequel-pro
- spotify
- srm
- synology-cloud-station-backup
- synology-drive
- thefuck
- toggl
- tunnelblick
- ubersicht
- veracrypt
- virtualbox
- virtualbox-extension-pack
- vlc
- wget
- whatsapp
- yarn
- zsh

### Installation

```bash
$ sh ./install.sh personal # To install personal profile
$ sh ./install.sh work # To install work profile
$ sh ./install.sh personal work # To install both personal and work profiles
```

## oh-my-zsh.sh

This script will install **oh-my-zsh** with the [Powerlevel9k theme](https://github.com/bhilburn/powerlevel9k).
You need to install zsh and iTerm2 first.

### Usage

```bash
$ sh ./oh-my-zsh.sh
```

**You have to manually select the Hack Nerd Font in your iTerm2 profile**
