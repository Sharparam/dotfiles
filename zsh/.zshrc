typeset -aUx path
fpath=($HOME/.zsh $HOME/.zfunc $fpath)
path=($HOME/.local/bin "$HOME/.cargo/bin" $path)
path[$path[(i)/mnt/c/Ruby/bin]]=()

if [[ $IS_WSL == true ]];
then
  echo '[WSL] Disabling setting priority on background processes'
  unsetopt BG_NICE
  echo '[WSL] Setting umask to 022'
  umask 022
fi

take() { mkdir -p "$1" && cd "$1" }
gake() { take "$1" && git init }

### Added by Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### BEGIN ZPLUGIN BLOCK ###

wsl_fix_fsh() {
  if [[ $IS_WSL == false ]]; then
    return
  fi
  #echo "[WSL] Fixing fast-syntax-highlighting"
  FAST_HIGHLIGHT[chroma-git]="chroma/-ogit.ch"
}

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# if [[ "$TERM_PROGRAM" != "WarpTerminal" ]]; then
#   PURE_GIT_PULL=0
#   zstyle :prompt:pure:git:stash show yes
#   zinit ice pick"async.zsh" src"pure.zsh"
#   zinit light sindresorhus/pure
# fi

zinit ice pick"themes/catppuccin_${CATPPUCCIN_THEME}-zsh-syntax-highlighting.zsh"
zinit light "catppuccin/zsh-syntax-highlighting"

zinit ice wait lucid
# zinit light molovo/tipz
zinit light djui/alias-tips

#if [[ $IS_WSL == false ]]; then
#  zinit ice wait
#  zinit light marzocchi/zsh-notify
#fi

_fix-pzt-module() {
  if [[ ! -f ._zinit/teleid ]] then return 0; fi
  if [[ ! $(cat ._zinit/teleid) =~ "^PZT::.*" ]] then return 0; fi
  local PZTM_NAME=$(cat ._zinit/teleid | sed -n 's/PZT::modules\///p')
  git clone --quiet --no-checkout --depth=1 --filter=tree:0 https://github.com/sorin-ionescu/prezto
  cd prezto
  git sparse-checkout set --no-cone modules/$PZTM_NAME
  git checkout --quiet
  cd ..
  local file
  for file in prezto/modules/$PZTM_NAME/*~(.gitignore|*.plugin.zsh)(D); do
    local filename="${file:t}"
    echo "Copying $file to $(pwd)/$filename..."
    cp -R $file $filename
  done
  rm -rf prezto
}

zstyle ':prezto:*:*' color 'yes'
zinit snippet PZTM::helper/init.zsh
zinit snippet PZTM::spectrum/init.zsh
zinit snippet PZTM::history/init.zsh
zinit snippet PZTM::environment/init.zsh
zinit snippet PZTM::directory/init.zsh

zstyle ':prezto:module:utility' safe-ops 'no'
zinit ice atpull"%atclone" atclone"_fix-pzt-module"
zinit snippet PZT::modules/utility

zinit ice atpull"%atclone" atclone"_fix-pzt-module"
zinit snippet PZT::modules/git
#zinit snippet PZTM::ssh/init.zsh
#zinit snippet PZTM::gpg/init.zsh

zinit ice atpull"%atclone" atclone"_fix-pzt-module"
zinit snippet PZT::modules/ruby
zinit snippet PZTM::rails/init.zsh

zstyle ':prezto:module:python:virtualenv' auto-switch 'yes'
zinit ice atpull"%atclone" atclone"_fix-pzt-module"
zinit snippet PZT::modules/python

zinit ice atpull"%atclone" atclone"_fix-pzt-module"
zinit snippet PZT::modules/node

zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

zinit ice blockf \
  atpull"_fix-pzt-module" \
  atclone"_fix-pzt-module && git clone --recursive https://github.com/zsh-users/zsh-completions external"
zinit snippet PZT::modules/completion

zinit ice ver"feat/clone-remote"
zinit light itsbth/zsh-fzf-ghq

[[ -f "/usr/share/fzf/completion.zsh" ]] && source /usr/share/fzf/completion.zsh
[[ -f "/usr/share/fzf/key-bindings.zsh" ]] && source /usr/share/fzf/key-bindings.zsh

_dotnet_zsh_complete() {
  local completions=("$(dotnet complete "$words")")
  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

# fast-syntax-highlighting is very slow in certain contexts at least on WSL
# Needs testing on non-WSL to see if slowness persists
if [[ $IS_WSL == true ]]; then
  zinit ice wait lucid atinit"zicompinit; zicdreplay -q"
  zinit light zsh-users/zsh-syntax-highlighting
else
  zinit ice wait lucid atinit"zicompinit; zicdreplay -q" atload"wsl_fix_fsh"
  zinit light zdharma-continuum/fast-syntax-highlighting
fi

autoload -Uz compinit
compinit
zinit cdreplay -q

### END ZPLUGIN BLOCK ###

if (( $+commands[jj] == 1 )); then
  source <(COMPLETE=zsh jj)
fi

[ -f "$HOME/.config/op/plugins.sh" ] && source "$HOME/.config/op/plugins.sh"

[ $+commands[zoxide] -eq 1 ] && eval "$(zoxide init --cmd j zsh)"

if [[ $IS_WSL == false ]];
then
  [ $+commands[thefuck] -eq 1 ] && eval "$(thefuck --alias)"
  [ $+commands[hub] -eq 1 ] && eval "$(hub alias -s)"
fi

if (( $+commands[atuin] == 1 )); then
  eval "$(atuin init zsh)"
fi

if [[ -d "/usr/share/perl6/" ]]; then
    path=(/usr/share/perl6/vendor/bin /usr/share/perl6/site/bin $path)
fi

if [[ -d "$HOME/.dotnet/tools" ]]; then
    path=($HOME/.dotnet/tools $path)
fi

if [[ -d "$HOME/.config/emacs/bin" ]]; then
    path=($HOME/.config/emacs/bin $path)
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

if [[ $IS_WSL == true ]]; then
  [ -f $HOME/qmk_utils/activate_wsl.sh ] && source $HOME/qmk_utils/activate_wsl.sh
fi

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'

# ls aliases
if [[ $+commands[lsd] -eq 1 ]]; then
  alias ls='lsd --group-dirs first'
  alias l='ls --oneline --all'
  alias ll='ls --long'
  alias la='ll --all'
else
  alias ls='\ls --color=auto --group-directories-first --time-style=long-iso --kibibytes'
  alias l='ls -1 --all'
  alias ll='ls -lh'
  alias la='ll --all'
fi

# Git aliases
alias ga='git add'
alias gst='git status'
alias gdt='git difftool'

alias vi='nvim'
alias vim='nvim'

# Vim in terminal
alias ':q'='exit'
alias ':wq'='exit'
alias ':x'='exit'

# Emacs stuff
#alias emacs='emacs -nw'
alias emacs='emacsclient -nc'

alias zed='zeditor'

# Ruby aliases
alias rbbi='bundle install'

# Use code insiders by default if present
# if [[ $+commands[code-insiders] -eq 1 ]]; then
#   alias code=code-insiders
# fi

# Work laptop aliases
if [[ "$HOST" = "PC673" ]]; then
  alias smerge='"/mnt/c/Program Files/Sublime Merge/sublime_merge.exe"'
elif [[ "$HOST" = "SHARPARAM-PC" ]]; then
  alias smerge='"/mnt/c/Program Files/Sublime Merge/sublime_merge.exe"'
fi

# Helix aliases
alias hx=helix

alias rsync='rsync --info=progress2 --partial -h'

alias fsi='dotnet fsi'
alias fsharpi='dotnet fsi'

if [[ $+commands[bat] -eq 1 ]]; then
  alias cat='bat --paging=never'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT='-c'
fi

# GitHub CLI aliases
alias '?'='gh copilot suggest -t shell'
alias '?g'='gh copilot suggest -t git'
alias '?gh'='gh copilot suggest -t gh'
alias '??'='gh copilot explain'
alias '?e'='gh copilot explain'

if [[ $+commands[direnv] -eq 1 ]]; then
  eval "$(direnv hook zsh)"
fi

if [[ -d "$HOME/.perl5/bin" ]]; then
  path=("$HOME/.perl5/bin" $path)
fi

if [[ -d "$HOME/.rakubrew" ]]; then
  eval "$($HOME/.rakubrew/bin/rakubrew init Zsh)"
fi

# Following two functions and utilities from:
# https://github.com/BlackReloaded/wsl2-ssh-pageant
wsl-gpg-proxy() {
  local appdata=$(cmd.exe /c echo %LOCALAPPDATA%)
  if [[ -z "$appdata" ]]; then
    echo "appdata empty, returning"
    return
  fi
  local gpg_conf_base="$(echo -E "${appdata}" | tr -d '[:space:]' | tr '\\' '/')/gnupg"
  local gpg_socket_dir="$(gpgconf --list-dirs socketdir)"
  mkdir -p "$gpg_socket_dir" || echo "Failed to create GPG socket dir $gpg_socket_dir"
  echo "GPG conf base: $gpg_conf_base; socket dir: $gpg_socket_dir"
  export GPG_AGENT_SOCK="$gpg_socket_dir/S.gpg-agent"
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
if [[ $IS_WSL == true ]]; then
  if [[ -n "${XDG_SESSION_ID}" && "${TERM}" == "dumb" && "$(ps -p $PPID -o comm=)" == "login" ]]; then
    # Background login process, do nothing
  else
    # echo '[WSL] Configuring GPG and SSH'
    # wsl-gpg-proxy
    # wsl-ssh-proxy
  fi
else
  #if [ "$HOST" = "melina" ]; then
  #  if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  #    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
  #  fi
  #  if [[ ! "$SSH_AUTH_SOCK" ]]; then
  #    source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
  #  fi
  #else
  # Experiment with 1Password as SSH agent for a bit,
  # so disable these env vars for now (see .zshenv)
  # unset SSH_AGENT_PID
  # export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  #fi
  gpgconf --launch gpg-agent
fi

if [[ -d '/usr/local/go/bin' ]]; then
  path+=(/usr/local/go/bin)
fi

if [[ -d "$GOPATH/bin" ]]; then
  path+=("$GOPATH/bin")
fi

if [[ -f "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
elif [[ $+commands[mise] -eq 1 ]]; then
  eval "$(mise activate zsh)"
fi

# bun
if [[ -d "$BUN_INSTALL" ]]; then
  # bun completions
  [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
  [ -d "$BUN_INSTALL/bin" ] && path=("$BUN_INSTALL/bin" $path)
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.local/share/google-cloud-cli/path.zsh.inc" ]; then . "$HOME/.local/share/google-cloud-cli/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.local/share/google-cloud-cli/completion.zsh.inc" ]; then . "$HOME/.local/share/google-cloud-cli/completion.zsh.inc"; fi

# if [[ "$TERM_PROGRAM" == "WarpTerminal" ]] && [[ $+commands[starship] -eq 1 ]]; then
if [[ $+commands[starship] -eq 1 ]]; then
  eval "$(starship init zsh)"
fi

launch() {
  nohup $@ &>/dev/null & disown
}

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

scrotclip() {
  scrot $@ /tmp/scrotclip.png -e 'xclip -se c -t image/png -i $f && rm $f'
}

pj() {
  pushd "$(j -e $@)"
}

term_name=$(basename "$(ps -p $(ps -p $$ -o ppid=) -o args=)")
if [[ "$term_name" != "yakuake" && $+commands[cowsay] -eq 1 && $+commands[fortune] -eq 1 && ! $ASCIINEMA_REC && -z "$TMUX" ]]; then
  cowfortune
fi
