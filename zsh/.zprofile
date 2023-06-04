if [[ -o login ]] && ! [[ -o interactive ]]; then
  if [[ -d "$HOME/.rbenv/bin" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
  fi
fi

