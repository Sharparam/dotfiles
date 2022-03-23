typeset -aUx path
fpath=($HOME/.zsh $HOME/.zfunc $HOME/.luaver/completions $fpath)
path=($HOME/.local/bin "$path[@]")
path[$path[(i)/mnt/c/Ruby/bin]]=()
export path

if grep -iq Microsoft /proc/version; then
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

take() { mkdir -p "$1" && cd "$1" }
gake() { take "$1" && git init }

if [ "$HOST" = "melina" ]; then
  export TERMINAL="kitty"
elif [ ! $is_wsl ]; then
  export TERMINAL="alacritty"
fi

export _Z_CMD=j

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma-continuum/zinit)…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
    print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### BEGIN ZPLUGIN BLOCK ###

wsl_fix_fsh() {
  if [ ! $is_wsl ]; then
    return
  fi
  #echo "[WSL] Fixing fast-syntax-highlighting"
  FAST_HIGHLIGHT[chroma-git]="chroma/-ogit.ch"
}

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-history-substring-search

PURE_GIT_PULL=0
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice atload"base16_${BASE16_THEME}"
zinit light "chriskempson/base16-shell"

zinit ice from"gh-r" pick"hub-*/bin/hub" as"command" bpick"*linux-amd64*"
zinit light github/hub
zinit ice wait lucid as"completion" mv"*ion -> _hub" blockf
zinit snippet https://github.com/github/hub/raw/master/etc/hub.zsh_completion

zinit ice from"gh-r" as"command" mv"hivemind-* -> hivemind"
zinit light DarthSim/hivemind

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf-bin

zinit ice pick"bin/fzf-tmux" as"program" multisrc"shell/{completion,key-bindings}.zsh" blockf
zinit light junegunn/fzf

zinit ice wait lucid
zinit light molovo/tipz

#if [ ! $is_wsl ]; then
#  zinit ice wait
#  zinit light marzocchi/zsh-notify
#fi

zstyle ':prezto:*:*' color 'yes'
zinit snippet PZTM::helper/init.zsh
zinit snippet PZTM::history/init.zsh
zinit snippet PZTM::environment/init.zsh
zinit snippet PZTM::directory/init.zsh

zstyle ':prezto:module:utility' safe-ops 'no'
zinit ice svn
zinit snippet PZTM::utility

zinit ice svn
zinit snippet PZTM::git
#zinit snippet PZTM::ssh/init.zsh
#zinit snippet PZTM::gpg/init.zsh

zinit ice svn
zinit snippet PZTM::ruby
zinit snippet PZTM::rails/init.zsh

zstyle ':prezto:module:python:virtualenv' auto-switch 'yes'
zinit ice svn
zinit snippet PZTM::python

zinit ice svn
zinit snippet PZTM::node

zinit ice from"gh-r" bpick"*linux_amd64*" pick"ghq_*/ghq" as"program"
zinit light x-motemen/ghq

zinit light zdharma-continuum/zui
#zinit light zdharma-continuum/zplugin-crasis

zinit light supercrabtree/k
zinit light rupa/z

zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

zinit ice svn blockf \
  atclone"git clone --recursive https://github.com/zsh-users/zsh-completions external"
zinit snippet PZTM::completion

# fast-syntax-highlighting is very slow in certain contexts at least on WSL
# Needs testing on non-WSL to see if slowness persists
if [[ $is_wsl ]]; then
  zinit ice wait lucid atinit"zicompinit; zicdreplay -q"
  zinit light zsh-users/zsh-syntax-highlighting
else
  zinit ice wait lucid atinit"zicompinit; zicdreplay -q" atload"wsl_fix_fsh"
  zinit light zdharma-continuum/fast-syntax-highlighting
fi

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

alias vi='nvim'
alias vim='nvim'

# Vim in terminal
alias ':q'='exit'
alias ':wq'='exit'
alias ':x'='exit'

# Emacs stuff
alias emacs='emacs -nw'

if [[ -d "$HOME/.poetry/bin" ]]; then
  path=($HOME/.poetry/bin "$path[@]")
fi

if [[ -d "$HOME/.rakubrew" ]]; then
  eval "$($HOME/.rakubrew/bin/rakubrew init Zsh)"
fi

# Following two functions and utilities from:
# https://github.com/BlackReloaded/wsl2-ssh-pageant
wsl-gpg-proxy() {
  local appdata=$(cmd.exe /c echo %APPDATA%)
  if [[ "$HOST" == "PC673" ]]; then
    appdata=$(cmd.exe /c echo %LOCALAPPDATA%)
  fi
  local gpg_conf_base="$(echo -E "${appdata}" | tr -d '[:space:]' | tr '\\' '/')/gnupg"
  export GPG_AGENT_SOCK="$HOME/.gnupg/S.gpg-agent"
  if ! ss -a | grep -q "$GPG_AGENT_SOCK"; then
    rm -rf "$GPG_AGENT_SOCK"
    wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
    if test -x "$wsl2_ssh_pageant_bin"; then
      (setsid nohup socat UNIX-LISTEN:"$GPG_AGENT_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin --gpgConfigBasepath '${gpg_conf_base}' --gpg S.gpg-agent" >/dev/null 2>&1 &)
    else
      echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
    fi
    unset wsl2_ssh_pageant_bin
  fi
}

wsl-ssh-proxy() {
  export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
  if ! ss -a | grep -q "$SSH_AUTH_SOCK"; then
    rm -f "$SSH_AUTH_SOCK"
    wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
    if test -x "$wsl2_ssh_pageant_bin"; then
      (setsid nohup socat UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin" >/dev/null 2>&1 &)
    else
      echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
    fi
    unset wsl2_ssh_pageant_bin
  fi
}

export GPG_TTY="$(tty)"
if [[ $is_wsl ]]; then
  echo '[WSL] Configuring GPG and SSH'
  wsl-gpg-proxy
  wsl-ssh-proxy
else
  #if [ "$HOST" = "melina" ]; then
  #  if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  #    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
  #  fi
  #  if [[ ! "$SSH_AUTH_SOCK" ]]; then
  #    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
  #  fi
  #else
  unset SSH_AGENT_PID
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  #fi
  gpgconf --launch gpg-agent
fi

if [[ -d '/usr/local/go/bin' ]]; then
  path=("$path[@]" /usr/local/go/bin "$GOPATH/bin")
fi

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

pj() {
  pushd "$(j -e $@)"
}

term_name=$(basename $(ps -p $(ps -p $$ -o ppid=) -o args=))
if [[ "$term_name" != "yakuake" && $+commands[cowsay] && $+commands[fortune] && ! $ASCIINEMA_REC && -z "$TMUX" ]]; then
  cowfortune
fi
