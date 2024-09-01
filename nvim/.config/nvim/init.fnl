(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")
(vim.keymap.set :n "<Leader>m" "<LocalLeader>" {:remap true :desc "+<LocalLeader>"})

;; Disable netrw because we use nvim-tree instead
(set vim.g.loaded_netrw 1)
(set vim.g.loaded_netrwPlugin 1)

(require :config.lazy)
(require "config.options")
(require "config.autocmds")
(require "config.keymaps")
