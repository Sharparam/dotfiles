return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/neoconf.nvim',
        cmd = 'Neoconf',
        config = true
      },
      {
        'folke/neodev.nvim',
        opts = {}
      },
      'williamboman/mason.nvim',
      {
        'williamboman/mason-lspconfig.nvim',
        dependencies = 'williamboman/mason.nvim'
      },
      {
        'hrsh7th/cmp-nvim-lsp',
        cond = function()
          return require('utils').has('nvim-cmp')
        end
      }
    }
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {}
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end
  }
}
