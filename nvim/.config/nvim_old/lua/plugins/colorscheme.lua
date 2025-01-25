-- :fennel:1686673977
local function _1_(c)
  return {NotifyBackground = {fg = c.fg, bg = c.base}}
end
local function _2_(_, opts)
  do end (require("catppuccin")).setup(opts)
  return vim.cmd.colorscheme("catppuccin")
end
return {{name = "catppuccin", priority = 1000, cond = not vim.g.vscode, opts = {flavour = "macchiato", transparent_background = true, show_end_of_buffer = true, styles = {comments = {"italic"}, conditionals = {}}, integrations = {cmp = true, gitsigns = true, leap = true, lsp_trouble = true, markdown = true, mason = true, mini = true, native_lsp = {enabled = true}, noice = true, notify = true, nvimtree = true, telescope = true, treesitter = true, treesitter_context = true, which_key = true}, custom_highlights = _1_}, config = _2_, lazy = false, "catppuccin/nvim"}}