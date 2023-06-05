return {
  { 'tpope/vim-commentary' },
  { 'tpope/vim-endwise' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },

  {
    'ggandor/leap.nvim',
    dependencies = 'tpope/vim-repeat',
    config = function()
      local leap = require 'leap'
      leap.add_default_mappings()
      leap.opts.highlight_unlabeled_phase_one_targets = true
    end
  },
  {
    'ggandor/flit.nvim',
    dependencies = 'ggandor/leap.nvim',
    opts = {
      multiline = true
    }
  }
}
