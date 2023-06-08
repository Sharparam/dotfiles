-- :fennel:1686177743
local function _1_()
  local integration = require("ts_context_commentstring.integrations.comment_nvim")
  return {pre_hook = integration.create_pre_hook()}
end
local function _2_()
  local leap = require("leap")
  leap.add_default_mappings()
  leap.opts.highlight_unlabeled_phase_one_targets = true
  return nil
end
local function _3_()
  vim.o.timeout = true
  vim.o.timeoutlen = 500
  return nil
end
local function _4_(_, opts)
  do
    local wk = require("which-key")
    wk.setup(opts)
  end
  return require("config.which_key")
end
return {{"tpope/vim-repeat"}, {dependencies = "JoosepAlviste/nvim-ts-context-commentstring", opts = _1_, "numToStr/Comment.nvim"}, {dependencies = "tpope/vim-repeat", config = _2_, "ggandor/leap.nvim"}, {dependencies = "ggandor/leap.nvim", opts = {multiline = true}, "ggandor/flit.nvim"}, {event = "VeryLazy", init = _3_, opts = {}, config = _4_, "folke/which-key.nvim"}}