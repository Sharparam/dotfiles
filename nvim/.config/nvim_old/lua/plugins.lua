-- :fennel:1686673977
local function _1_()
  if not vim.g.vscode then
    local integration = require("ts_context_commentstring.integrations.comment_nvim")
    return {pre_hook = integration.create_pre_hook()}
  else
    return {}
  end
end
local function _3_()
  local leap = require("leap")
  leap.add_default_mappings()
  leap.opts.highlight_unlabeled_phase_one_targets = true
  return nil
end
local function _4_()
  vim.o.timeout = true
  vim.o.timeoutlen = 500
  return nil
end
local function _5_(_, opts)
  do
    local wk = require("which-key")
    wk.setup(opts)
  end
  return require("config.which-key")
end
return {{"tpope/vim-repeat"}, {dependencies = {{cond = not vim.g.vscode, "JoosepAlviste/nvim-ts-context-commentstring"}}, opts = _1_, "numToStr/Comment.nvim"}, {dependencies = "tpope/vim-repeat", config = _3_, "ggandor/leap.nvim"}, {dependencies = "ggandor/leap.nvim", opts = {multiline = true}, "ggandor/flit.nvim"}, {event = "VeryLazy", init = _4_, opts = {}, config = _5_, "folke/which-key.nvim"}}