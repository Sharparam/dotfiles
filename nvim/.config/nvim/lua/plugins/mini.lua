return {
  {
    'echasnovski/mini.ai',
    version = false,
    config = true
  },
  {
    'echasnovski/mini.bracketed',
    version = false,
    config = true
  },
  {
    'echasnovski/mini.bufremove',
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
    'echasnovski/mini.indentscope',
    version = false,
    opts = function()
      local indentscope = require 'mini.indentscope'
      return {
        draw = {
          animation = indentscope.gen_animation.none()
        }
      }
    end
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    config = true
  },
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
    'echasnovski/mini.trailspace',
    version = false,
    keys = {
      { '<Leader>cw', function() require('mini.trailspace').trim() end, desc = 'Trim trailing whitespace' },
      { '<Leader>cW', function() require('mini.trailspace').trim_last_lines() end, desc = 'Trim trailing empty lines' }
    },
    config = true
  }
}
