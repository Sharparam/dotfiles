-- :fennel:1686361833
local set_binds
local function _1_(e)
  local bufnr = e.buf
  local wk = require("which-key")
  wk.register({E = {"<Cmd>FnlBuffer<CR>", "Eval buffer"}, L = {"<Cmd>FnlPeek<CR>", "Peek buffer"}, O = {"<Cmd>FnlGotoOutput<CR>", "Go to output"}}, {mode = "n", prefix = "<LocalLeader>e", buffer = bufnr})
  return wk.register({E = {"<Cmd>'<,'>FnlBuffer<CR>", "Eval selection"}, L = {"<Cmd>'<,'>FnlPeek<CR>", "Peek selection"}}, {mode = "v", prefix = "<LocalLeader>e", buffer = bufnr})
end
set_binds = _1_
return vim.api.nvim_create_autocmd("FileType", {pattern = "fennel", callback = set_binds, desc = "Set tangerine mappings in fennel files"})