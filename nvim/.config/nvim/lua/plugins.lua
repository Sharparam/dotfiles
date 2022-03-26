local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
  vim.cmd 'packadd packer.nvim'
end

local packer = require 'packer'

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'editorconfig/editorconfig-vim'

  use 'tomasiser/vim-code-dark'
end)
