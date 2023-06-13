[
  {
    1 :folke/zen-mode.nvim
    :cond (not vim.g.vscode)
    :keys
    [
      { 1 "<Leader>tz" 2 "<Cmd>ZenMode<CR>" :desc "Toggle Zen mode" }
    ]
    :opts
    {
      :plugins { :kitty { :enabled true } }
    }
  }
  {
    1 :folke/twilight.nvim
    :cond (not vim.g.vscode)
    :keys
    [
      { 1 "<Leader>tt" 2 "<Cmd>Twilight<CR>" :desc "Toggle Twilight" }
    ]
    :opts {}
  }
]
