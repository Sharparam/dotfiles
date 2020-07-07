if [[ -o login ]] && ! [[ -o interactive ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

