typeset -aUx path
fpath=($HOME/.zsh $HOME/.zfunc $HOME/.luaver/completions $fpath)
path=($HOME/.local/bin "$path[@]")
path[$path[(i)/mnt/c/Ruby/bin]]=()
export path

if grep -q Microsoft /proc/version; then
    is_wsl=1
else
    is_wsl=
fi

if [[ $is_wsl ]];
then
  echo '[WSL] Disabling setting priority on background processes'
  unsetopt BG_NICE
  echo '[WSL] Setting umask to 022'
  umask 022
fi

alias git=hub

take() { mkdir -p "$1" && cd "$1" }
gake() { take "$1" && git init }

export VISUAL="vim"
export EDITOR="vim"
export BROWSER="firefox"

if [ ! $is_wsl ]; then
  export TERMINAL="termite"
fi

export _Z_CMD=j

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
    print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### BEGIN ZPLUGIN BLOCK ###
zinit ice wait"0" blockf
zinit light zsh-users/zsh-completions

zinit ice wait"0" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

wsl_fix_fsh() {
  if [ ! $is_wsl ]; then
    return
  fi
  #echo "[WSL] Fixing fast-syntax-highlighting"
  FAST_HIGHLIGHT[chroma-git]="chroma/-ogit.ch"
}

# fast-syntax-highlighting is very slow in certain contexts at least on WSL
# Needs testing on non-WSL to see if slowness persists
if [[ $is_wsl ]]; then
  zinit ice wait"0"
  zinit light zsh-users/zsh-syntax-highlighting
else
  zinit ice wait"0" atinit"zpcompinit; zpcdreplay" atload"wsl_fix_fsh"
  zinit light zdharma/fast-syntax-highlighting
fi


zinit ice wait"0"
zinit light zsh-users/zsh-history-substring-search

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice from"gh-r" pick"hub-*/bin/hub" as"command" bpick"*linux-amd64*"
zinit light 'github/hub'

zinit ice from"gh-r" as"command" mv"hivemind-* -> hivemind"
zinit light DarthSim/hivemind

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf-bin

zinit ice pick"bin/fzf-tmux" as"program" multisrc"shell/{completion,key-bindings}.zsh"
zinit light junegunn/fzf

zinit ice wait"0"
zinit light molovo/tipz

#if [ ! $is_wsl ]; then
#  zinit ice wait"0"
#  zinit light marzocchi/zsh-notify
#fi

zstyle ':prezto:*:*' color 'yes'
zinit snippet PZT::modules/helper/init.zsh
zinit ice atload"[ -d external/ ] || git clone https://github.com/zsh-users/zsh-completions external"
zinit snippet PZT::modules/completion/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/environment/init.zsh
zinit snippet PZT::modules/directory/init.zsh

zstyle ':prezto:module:utility' safe-ops 'no'
zinit ice svn
zinit snippet PZT::modules/utility

zinit ice svn
zinit snippet PZT::modules/git
#zinit snippet PZT::modules/ssh/init.zsh
#zinit snippet PZT::modules/gpg/init.zsh

zinit ice svn
zinit snippet PZT::modules/ruby
zinit snippet PZT::modules/rails/init.zsh

zstyle ':prezto:module:python:virtualenv' auto-switch 'yes'
zinit ice svn
zinit snippet PZT::modules/python

zinit ice svn
zinit snippet PZT::modules/node

zinit ice from"gh-r" bpick"*linux_amd64*" pick"ghq_*/ghq" as"command"
zinit light x-motemen/ghq

zinit light zdharma/zui
zinit light zdharma/zplugin-crasis

zinit light supercrabtree/k
zinit light rupa/z

### END ZPLUGIN BLOCK ###

if [ ! $is_wsl ];
then
  eval "$(thefuck --alias)"
  eval "$(hub alias -s)"
fi

[ -s $HOME/.luaver/luaver ] && source $HOME/.luaver/luaver

if [[ -d "$HOME/.luaenv" ]]; then
  path=($HOME/.luaenv/bin $path)
  eval "$(luaenv init -)"
fi


if [[ -d "/usr/share/perl6/" ]]; then
    path=(/usr/share/perl6/vendor/bin /usr/share/perl6/site/bin $path)
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

if [[ $is_wsl ]]; then
  [ -f $HOME/qmk_utils/activate_wsl.sh ] && source $HOME/qmk_utils/activate_wsl.sh
fi

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'

# Git aliases
alias ga='git add'
alias gst='git status'

# Vim in terminal
alias ':q'='exit'
alias ':wq'='exit'
alias ':x'='exit'

if [[ -d "$HOME/.poetry/bin" ]]; then
  path=($HOME/.poetry/bin "$path[@]")

  # Fix for broken `poetry shell`
  # See: https://github.com/sdispater/poetry/issues/571#issuecomment-496486190
  #poetry() {
  #  if [[ $@ == 'shell' ]]; then
  #    activate_script="$(poetry run poetry env info -p)/bin/activate"
  #    if ([[ -f $activate_script ]] && [[ -z "${VIRTUAL_ENV:-}" ]]); then
  #      source $activate_script
  #    else
  #      command poetry "$@"
  #    fi
  #  else
  #    command poetry "$@"
  #  fi
  #}
fi

export GPG_TTY="$(tty)"
if [[ $is_wsl ]]; then
  wsl_gpg_agent_relay="$HOME/.local/bin/wsl-gpg-agent-relay.sh"
  if [[ -f "$wsl_gpg_agent_relay" ]]; then
    echo '[WSL] Launching WSL GPG agent relay'
    $wsl_gpg_agent_relay &
  else
    echo "[WSL] Missing: ${wsl_gpg_agent_relay}"
  fi
  unset SSH_AGENT_PID
  export SSH_AUTH_SOCK=$HOME/.local/wsl-ssh-pageant/ssh-agent.sock
else
  unset SSH_AGENT_PID
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
fi

if [[ -d '/usr/local/go/bin' ]]; then
  path=("$path[@]" /usr/local/go/bin)
fi
#export GOPATH="$HOME/go"

# tmux helpers
ts() {
    if [ $# -eq 0 ]; then
        tmux new-session
    else
        tmux new-session -s "$1"
    fi
}

ta() {
    if [ $# -eq 0 ]; then
        tmux attach-session
    else
        tmux attach-session -t "$1"
    fi
}

cowfortune() {
  cowargs=('-b' '-d' '-g' '-p' '-s' '-t' '-w' '-y' '')
  cowextra=${cowargs[$(($RANDOM % ${#cowargs[@]}))]}
  files=($(cowsay -l | tail -n +2))
  cowfile=${files[$((RANDOM % ${#files[@]} + 1))]}
  fortune $@ | cowsay -W 70 -f ${cowfile} ${cowextra}
}

thinkfortune () {
  fortune $@ | cowthink -W 70 -f bong -s
}

launch() {
  nohup $@ >&/dev/null &
}

scrotclip() {
  scrot $@ /tmp/scrotclip.png -e 'xclip -se c -t image/png -i $f && rm $f'
}

# WTF, Ansible?
export ANSIBLE_NOCOWS=1

if [ ! $ASCIINEMA_REC ]; then
  cowfortune
fi
