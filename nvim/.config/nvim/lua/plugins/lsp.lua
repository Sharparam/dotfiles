local wanted_servers = {
  'ansiblels',                       -- Ansible
  'bicep',                           -- Bicep
  'dockerls',                        -- Docker
  'docker_compose_language_service', -- Docker Compose
  'fennel_language_server',          -- Fennel
  'html',                            -- HTML
  'jsonls',                          -- JSON
  'tsserver',                        -- JavaScript/TypeScript
  'lua_ls',                          -- Lua
  'perlnavigator',                   -- Perl
  'raku_navigator',                  -- Raku
  'solargraph',                      -- Ruby
  'rust_analyzer',                   -- Rust
  'taplo',                           -- TOML
  'vimls',                           -- VimL
  'lemminx',                         -- XML
  'yamlls'                           -- YAML
}

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      {
        'neovim/nvim-lspconfig'
      },
      {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        cmd = 'Mason',
        config = true
      },
      {
        'williamboman/mason-lspconfig.nvim',
        dependencies = 'williamboman/mason.nvim'
      },

      {
        'hrsh7th/nvim-cmp',
        version = false,
        dependencies = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
          'L3MON4D3/LuaSnip',
          'saadparwaiz1/cmp_luasnip',
          'PaterJason/cmp-conjure'
        }
      },
      {
        'hrsh7th/cmp-nvim-lsp'
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
      },

      {
        'L3MON4D3/LuaSnip',
        build = function()
          if jit.os:find('Windows') then return nil end
          return 'echo "NOTE: jsregexp optional, failure to build is OK"; make install_jsregexp'
        end
      },
      {
        'rafamadriz/friendly-snippets',
      },

      {
        'folke/neoconf.nvim',
        -- cmd = 'Neoconf',
        config = true
      },
      {
        'folke/neodev.nvim',
        dependencies = 'hrsh7th/nvim-cmp',
        opts = {}
      },

      {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = 'williamboman/mason.nvim'
      },
      {
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
          'williamboman/mason.nvim',
          'jose-elias-alvarez/null-ls.nvim'
        }
      }
    },
    config = function(_, opts)
      local lsp = require('lsp-zero').preset {}

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map('n', 'gI', vim.lsp.buf.implementation, 'Go to implementation')
      end)

      lsp.format_mapping('gq', {
        format_opts = {
          async = true,
          timeout_ms = 10000
        },
        servers = {
          ['null-ls'] = {
            'javascript', 'typescript',
            'lua',
            'ruby',
            'c', 'cpp',
            'rust',
            'py'
          }
        }
      })

      lsp.setup()

      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          -- null_ls.builtins.formatting.prettier,
          -- null_ls.builtins.formatting.eslint
        }
      }

      require('mason-null-ls').setup {
        ensure_installed = nil,
        automatic_installation = true,
        handlers = {
        }
      }

      local cmp = require 'cmp'
      local cmp_action = require('lsp-zero').cmp_action()

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ['<S-Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          ['<C-e>'] = cmp.mapping.abort(),

          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        },
        sources = cmp.config.sources {
          {
            name = 'copilot',
            group_index = 2
          },
          { name = 'conjure' },
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
        formatting = {
          format = function(entry, item)
            local icons = require('config.icons').kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            item.menu = ({
              buffer = '[BUF]',
              nvim_lsp = '[LSP]',
              luasnip = '[SNP]',
              nvim_lua = '[LUA]',
              latex_symbols = '[LTX]',
              path = '[PTH]',
              cmdline = '[CMD]',
              copilot = '[COP]',
              conjure = '[CNJ]'
            })[entry.source.name]
            return item
          end
        },
        experimental = {
          ghost_text = { hl_group = 'NonText' }
        }
      }
    end
  }
}
