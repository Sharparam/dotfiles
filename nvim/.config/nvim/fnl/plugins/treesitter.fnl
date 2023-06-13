(local
  ensure-installed
  [
    :bash
    :bibtex
    :bicep
    :c
    :c_sharp
    :cmake
    :comment
    :commonlisp
    :cpp
    :css
    :diff
    :dockerfile
    :fennel
    :git_config
    :git_rebase
    :gitattributes
    :gitcommit
    :gitignore
    :haskell
    :html
    :http
    :ini
    :java
    :javascript
    :jq
    :jsdoc
    :json
    :json5
    :jsonc
    :jsonnet
    :kotlin
    :latex
    :llvm
    :lua
    :luadoc
    :luap
    :make
    :markdown
    :markdown_inline
    :meson
    :ninja
    :nix
    :org
    :passwd
    :perl
    :php
    :phpdoc
    :pug
    :python
    :racket
    :regex
    :ruby
    :rust
    :scheme
    :scss
    :slint
    :sql
    :svelte
    :terraform
    :todotxt
    :toml
    :tsx
    :typescript
    :vim
    :vimdoc
    :vue
    :yaml])

[{1 :nvim-treesitter/nvim-treesitter
  :version false
  :cond (not vim.g.vscode)
  :dependencies
  [
    :JoosepAlviste/nvim-ts-context-commentstring
    :RRethy/nvim-treesitter-endwise]

  :build ":TSUpdate"
  :opts
  {
    :ensure_installed ensure-installed
    :auto_install true
    :highlight
    {
      :enable true
      :additional_vim_regex_highlighting false}

    :context_commentstring { :enable true :enable_autocmd false}
    :endwise { :enable true}}

  :config
  (fn [_ opts] ((. (require :nvim-treesitter.configs) :setup) opts))}]
