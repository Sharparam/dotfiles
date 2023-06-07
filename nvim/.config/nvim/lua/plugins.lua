return {
  -- { 'tpope/vim-commentary' },
  -- { 'tpope/vim-endwise' },
  { 'tpope/vim-repeat' },
  -- { 'tpope/vim-surround' },

  {
    'numToStr/Comment.nvim',
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    opts = function()
      local integration = require 'ts_context_commentstring.integrations.comment_nvim'
      return {
        pre_hook = integration.create_pre_hook()
      }
    end
  },

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
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
    config = function(_, opts)
      require('which-key').setup(opts)
      require 'config.which_key'
    end
  }
}
