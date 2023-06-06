local available = {
  vscode = {
    {
      'Mofiqul/vscode.nvim',
      lazy = false,
      priority = 1000,
      opts = {
        italic_comments = true,
      },
      config = function(_, opts)
        require 'config.colorscheme'
        local vscode = require 'vscode'
        vscode.setup(opts)
        vscode.load()
      end
    }
  },
  tokyonight = {
    {
      'folke/tokyonight.nvim',
      lazy = false,
      priority = 1000,
      opts = {
        style = 'night', -- storm, night, moon, day
        styles = {
          comments = { italic = true },
          sidebars = 'dark',
          floats = 'dark'
        },
        sidebars = { 'NvimTree', 'qf', 'help', 'lazy' }
      },
      config = function(_, opts)
        require 'config.colorscheme'
        require('tokyonight').setup(opts)
        vim.cmd [[colorscheme tokyonight]]
      end
    }
  }
}

return available.tokyonight
