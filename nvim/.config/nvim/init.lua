vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.keymap.set('n', '<Leader>m', '<LocalLeader>', { remap = true, desc = '+<LocalLeader>' })

-- Disable netrw because we use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

-- Configure ggandor/leap.nvim
local leap = require 'leap'
leap.add_default_mappings()
leap.opts.highlight_unlabeled_phase_one_targets = true

require 'config.options'
require 'config.autocmds'
require 'config.keymaps'
