return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    keys = {
      { '<leader>bP', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle pin' },
      { '<leader>bU', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = 'Delete unpinned buffers' },
      { '<leader>bb', '<cmd>BufferLinePick<cr>', desc = 'Pick buffer' },
      { '<leader>bD', '<cmd>BufferLinePickClose<cr>', desc = 'Pick buffer to close' }
    },
    opts = function()
      local bufferline = require 'bufferline'
      local icons = require 'config.icons'
      local diag = {
        error = icons.diagnostics.Error,
        warning = icons.diagnostics.Warn,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Info
      }
      local diag_fb = icons.diagnostics.Info
      -- local muted = { fg = { attribute = 'fg', highlight = 'NonText' } }
      return {
        options = {
          mode = 'buffers',
          style_preset = {
            bufferline.style_preset.no_italic
          },
          themable = true,
          numbers = 'both',
          middle_mouse_command = 'bdelete! %d',
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = ' '
            for e, n in pairs(diagnostics_dict) do
              local sym = diag[e] or diag_fb
              s = s .. n .. sym
            end
            return s
          end,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              text_align = 'center',
              highlight = 'Directory',
              separator = true
            }
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          separator_style = 'thin',
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
          }
        },
        highlights = {
          -- background = muted,
          -- tab = muted,
          -- tab_close = muted,
          -- close_button = muted,
          -- close_button_visible = muted,
          -- buffer_visible = muted,
          -- numbers = muted,
          -- numbers_visible = muted,
          -- diagnostic = muted,
          -- diagnostic_visible = muted,
          -- hint = muted,
          -- hint_visible = muted,
          -- hint_diagnostic = muted,
          -- hint_diagnostic_visible = muted,
          -- info = muted,
          -- info_visible = muted,
          -- info_diagnostic = muted,
          -- info_diagnostic_visible = muted,
          -- warning = muted,
          -- warning_visible = muted,
          -- warning_diagnostic = muted,
          -- warning_diagnostic_visible = muted,
          -- error = muted,
          -- error_visible = muted,
          -- error_diagnostic = muted,
          -- error_diagnostic_visible = muted,
          -- duplicate_selected = muted,
          -- duplicate_visible = muted,
          -- duplicate = muted,
          -- separator_visible = muted,
          -- separator = muted
        }
      }
    end,
    config = function(_, opts)
      require('bufferline').setup(opts)
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    opts = function(_, opts)
      opts = opts or {}
      local icons = require 'config.icons'
      local utils = require 'utils'
      local colors = {
        [''] = utils.fg('Special'),
        Normal = utils.fg('Special'),
        Warning = utils.fg('DiagnosticError'),
        InProgress = utils.fg('DiagnosticWarn')
      }

      return {
        options = {
          theme = 'tokyonight', -- 'auto'
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            {
              'branch',
              separator = ''
            },
            {
              'diff',
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              }
            }
          },
          lualine_c = {
            {
              'diagnostics',
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info
              }
            },
            {
              'filetype',
              icon_only = true,
              separator = '',
              padding = { left = 1, right = 0 }
            },
            {
              'filename',
              path = 1,
              symbols = {
                modified = "  ", readonly = "", unnamed = ""
              }
            },
            {
              function() return require('nvim-navic').get_location() end,
              cond = function() return package.loaded['nvim-navic'] and require('nvim-navic').is_available() end
            }
          },
          lualine_x = {
            {
              function() return require('noice').api.status.command.get() end,
              cond = function() return package.loaded['noice'] and require('noice').api.status.command.has() end,
              color = utils.fg('Statement'),
            },
            {
              function() return require('noice').api.status.mode.get() end,
              cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
              color = utils.fg('Constant'),
            },
            {
              function()
                local icon = icons.kinds.Copilot
                local status = require('copilot.api').status.data
                return icon .. (status.message or '')
              end,
              cond = function()
                local ok, clients = pcall(vim.lsp.get_active_clients, { name = 'copilot', bufnr = 0 })
                return ok and #clients > 0
              end,
              color = function()
                if not package.loaded['copilot'] then return end
                local status = require('copilot.api').status.data
                return colors[status.status] or colors['']
              end
            },
            {
              function() return '  ' .. require('dap').status() end,
              cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
              color = utils.fg('Debug'),
            },
            {
              require('lazy.status').updates,
              cond = require('lazy.status').has_updates, color = utils.fg('Special')
            }
          },
          lualine_y = { { 'encoding', separator = '' }, 'fileformat' },
          lualine_z = {
            { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
          }
        },
        extensions = {
          'lazy'
        }
      }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', desc = 'Find files' },
      { '<leader>.', '<Leader>ff', desc = 'Find files', remap = true },
      { '<leader>gff', '<cmd>Telescope git_files<cr>', desc = 'Find Git file' },
      { '<leader><leader>', '<cmd>Telescope git_files<cr>', desc = 'Find file in project' },
      { '<leader>sd', '<cmd>Telescope live_grep<cr>', desc = 'Search CWD' },
      { '<leader>bB', '<cmd>Telescope buffers<cr>', desc = 'List buffers' },
      { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'List marks' },
      { '<leader><cr>', '<cmd>Telescope marks<cr>', desc = 'List marks' },
      { '<leader>hn', '<cmd>Telescope notify<cr>', desc = 'List notifications' },
      { '<leader>cj', '<cmd>Telescope treesitter<cr>', desc = 'List treesitter objects' },
      { '<leader>clGb', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Find symbols in buffer' },
      { '<leader>clGc', '<cmd>Telescope lsp_incoming_calls<cr>', desc = 'List incoming calls' },
      { '<leader>clGC', '<cmd>Telescope lsp_outgoing_calls<cr>', desc = 'List outgoing calls' },
      { '<leader>clGe', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Show diagnostics' },
      { '<leader>clGE', '<cmd>Telescope diagnostics<cr>', desc = 'Show all diagnostics' },
      { '<leader>clGg', '<cmd>Telescope lsp_definitions<cr>', desc = 'Find definitions' },
      { '<leader>clGi', '<cmd>Telescope lsp_implementations<cr>', desc = 'Find implementations' },
      { '<leader>clGr', '<cmd>Telescope lsp_references<cr>', desc = 'Find references' },
      { '<leader>clGs', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'Find symbols in workspace' },
      { '<leader>clGS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Find symbols in workspace (dynamic)' },
      { '<leader>clGt', '<cmd>Telescope lsp_type_definitions<cr>', desc = 'Find type definitions' },
      { '<leader>hbB', '<cmd>Telescope keymaps<cr>', desc = 'List normal keymaps' },
      { '<leader>ib', '<cmd>Telescope builtin<cr>', desc = 'Built-in pickers' },
      { '<leader>id', '<cmd>Telescope symbols<cr>', desc = 'Symbols from data' },
      { '<leader>iP', '<cmd>Telescope planets<cr>', desc = 'Planets' }
    },
    config = function(_, opts)
      local telescope = require 'telescope'
      telescope.setup()
      telescope.load_extension('notify')
    end
  },
  {
    'stevearc/oil.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      columns = {
        'permissions',
        'size',
        'mtime',
        'icon'
      }
    }
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
      { '<leader>op', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle tree' },
      { '<leader>oP', '<cmd>NvimTreeFindFile<cr>', desc = 'Find file in tree'}
    },
    opts = {}
  },
  {
    'stevearc/dressing.nvim',
    opts = {}
  },
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify'
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true
        }
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false
      }
    }
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<Leader>cxx', '<Cmd>TroubleToggle<CR>', desc = 'Diagnostics' },
      { '<Leader>cxw', '<Cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace diagnostics' },
      { '<Leader>cxd', '<Cmd>TroubleToggle document_diagnostics<CR>', desc = 'Document diagnostics' },
      { '<Leader>cxq', '<Cmd>TroubleToggle quickfix<CR>', desc = 'Quickfix items' },
      { '<Leader>cxl', '<Cmd>TroubleToggle loclist<CR>', desc = 'Items from location list' },
    },
    opts = {}
  },
  {
    'rcarriga/nvim-notify',
    opts = {}
  },
  {
    'Bekaboo/deadcolumn.nvim',
    opts = {
      scope = 'line', -- or 'buffer'
      modes = {
        -- 'n', 'no', 'nov', 'noV',
        'niI', 'niR', 'niV',
        'i', 'ic', 'ix',
        'R', 'Rc', 'Rx', 'Rv', 'Rvc', 'Rvx'
      },
      -- modes = function() return true end,
      blending = {
        threshold = 0.75,
        colorcode = '#000000',
        hlgroup = {
          'Normal',
          'background'
        }
      },
      warning = {
        alpha = 0.4,
        offset = 0,
        colorcode = '#FF0000',
        hlgroup = {
          'Error',
          'foreground'
        }
      },
      extra = {
        follow_tw = '+1'
      }
    }
  }
  -- {
  --   'ecthelionvi/NeoColumn.nvim',
  --   event = 'VeryLazy',
  --   keys = {
  --     { '<leader>tc', '<cmd>ToggleNeoColumn<cr>', desc = 'Toggle column' }
  --   },
  --   opts = {
  --     fg_color = '#FF0000',
  --     bg_color = '#00FF00',
  --     NeoColumn = { '80', '120' }
  --   }
  -- }
}
