-- :fennel:1725200379
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<Leader>m", "<LocalLeader>", {remap = true, desc = "+<LocalLeader>"})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("config.lazy")
require("config.options")
require("config.autocmds")
return require("config.keymaps")