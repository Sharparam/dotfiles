typeset -aUx path
fpath=($HOME/.zsh $fpath)
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

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

### BEGIN ZPLUGIN BLOCK ###
zplugin ice wait"0" blockf
zplugin light zsh-users/zsh-completions

zplugin ice wait"0" atload"_zsh_autosuggest_start"
zplugin light zsh-users/zsh-autosuggestions

wsl_fix_fsh() {
  if [ ! $is_wsl ]; then
    return
  fi
  #echo "[WSL] Fixing fast-syntax-highlighting"
  FAST_HIGHLIGHT[chroma-git]="chroma/-ogit.ch"
}

zplugin ice wait"0" atinit"zpcompinit; zpcdreplay" atload"wsl_fix_fsh"
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait"0"
zplugin light zsh-users/zsh-history-substring-search

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin ice from"gh-r" pick"hub-*/bin/hub" as"command" bpick"*linux-amd64*"
zplugin light 'github/hub'

zplugin ice from"gh-r" as"command" mv"hivemind-* -> hivemind"
zplugin light DarthSim/hivemind

zplugin ice from"gh-r" as"program"
zplugin light junegunn/fzf-bin

zplugin ice pick"bin/fzf-tmux" as"program" multisrc"shell/{completion,key-bindings}.zsh"
zplugin light junegunn/fzf

zplugin ice wait"0"
zplugin light molovo/tipz

zplugin ice wait"0"
zplugin light marzocchi/zsh-notify

zstyle ':prezto:*:*' color 'yes'
zplugin snippet PZT::modules/helper/init.zsh
zplugin ice atload"[ -d external/ ] || git clone https://github.com/zsh-users/zsh-completions external"
zplugin snippet PZT::modules/completion/init.zsh
zplugin snippet PZT::modules/history/init.zsh
zplugin snippet PZT::modules/environment/init.zsh
zplugin snippet PZT::modules/directory/init.zsh

zstyle ':prezto:module:utility' safe-ops 'no'
zplugin ice svn
zplugin snippet PZT::modules/utility/

zplugin ice svn
zplugin snippet PZT::modules/git/
zplugin snippet PZT::modules/ssh/init.zsh
zplugin snippet PZT::modules/gpg/init.zsh

zplugin ice svn
zplugin snippet PZT::modules/ruby/
zplugin snippet PZT::modules/rails/init.zsh

zstyle ':prezto:module:python:virtualenv' auto-switch 'yes'
zplugin ice svn
zplugin snippet PZT::modules/python/

zplugin ice from"gh-r" bpick"*linux_amd64*" pick"ghq_*/ghq" as"command"
zplugin light motemen/ghq

zplugin light zdharma/zui
zplugin light zdharma/zplugin-crasis

zplugin light supercrabtree/k
zplugin light rupa/z

### END ZPLUGIN BLOCK ###

if [ ! $is_wsl ];
then
  eval "$(thefuck --alias)"
  eval "$(hub alias -s)"
fi

if [[ -d "/usr/share/perl6/" ]]; then
    path=(/usr/share/perl6/vendor/bin /usr/share/perl6/site/bin $path)
fi

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'

# Git aliases
alias ga='git add'
alias gst='git status'

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