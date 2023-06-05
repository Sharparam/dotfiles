return {
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
}
