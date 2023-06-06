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
    'echasnovski/mini.pairs',
    version = false,
    config = true
  },
  -- {
  --   'echasnovski/mini.comment',
  --   version = false,
  --   dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  --   opts = {
  --     options = {
  --       custom_commentstring = function()
  --         return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
  --       end
  --     }
  --   }
  -- },
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {
      mappings = {
        add = 'gza',
        delete = 'gzd',
        find = 'gzf',
        find_left = 'gzF',
        highlight = 'gzh',
        replace = 'gzr',
        update_n_lines = 'gzn',
        suffix_last = 'l',
        sufix_next = 'n'
      }
    }
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
