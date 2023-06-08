return {
  {
    'folke/zen-mode.nvim',
    keys = {
      { '<Leader>tz', '<Cmd>ZenMode<CR>', desc = 'Toggle Zen mode' }
    },
    opts = {
      plugins = {
        kitty = {
          enabled = true
        }
      }
    }
  },
  {
    'folke/twilight.nvim',
    keys = {
      { '<Leader>tt', '<Cmd>Twilight<CR>', desc = 'Toggle Twilight' }
    },
    opts = {}
  }
}
