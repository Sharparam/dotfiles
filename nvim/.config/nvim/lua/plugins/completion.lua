return {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      {
        'zbirenbaum/copilot-cmp',
        dependencies = 'zbirenbaum/copilot.lua',
        main = 'copilot_cmp',
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require 'copilot_cmp'
          copilot_cmp.setup(opts)
          require('utils').on_attach(function(client)
            if client.name == 'copilot' then
              copilot_cmp._on_insert_enter {}
            end
          end)
        end
      }
    },
    opts = function()
      local cmp = require 'cmp'
      return {
        completion = {
          completeopt = 'menu,menuone,noinsert'
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<S-CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources {
          {
            name = 'copilot',
            group_index = 2
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'cmdline' }
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require('copilot_cmp.comparators').prioritize,
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order
          }
        },
        experimental = {
          ghost_text = {
            hl_group = 'LspCodeLens'
          }
        }
      }
    end
  },
  {
    'zbirenbaum/copilot.lua',
    build = ':Copilot auth',
    cmd = 'Copilot',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false }
    }
  },
}
