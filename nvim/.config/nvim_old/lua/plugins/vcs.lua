-- :fennel:1686673977
local function _1_()
  return (require("gitsigns")).stage_hunk({vim.fn.line("."), vim.fn.line("v")})
end
local function _2_()
  return (require("gitsigns")).reset_hunk({vim.fn.line("."), vim.fn.line("v")})
end
local function _3_()
  return (require("gitsigns")).blame_line({full = true})
end
local function _4_(bufnr)
  local gs = package.loaded.gitsigns
  local map
  local function _5_(mode, l, r, opts)
    local opts0 = (opts or {})
    opts0.buffer = bufnr
    return vim.keymap.set(mode, l, r, opts0)
  end
  map = _5_
  return map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", {desc = "Select hunk"})
end
local function _6_(_, opts)
  return (require("gitsigns")).setup(opts)
end
return {{event = "VeryLazy", cond = not vim.g.vscode, keys = {{desc = "Toggle signs", "<Leader>gTs", "<Cmd>Gitsigns toggle_signs<CR>"}, {desc = "Toggle num highlight", "<Leader>gTn", "<Cmd>Gitsigns toggle_numhl<CR>"}, {desc = "Toggle line highlight", "<Leader>gTl", "<Cmd>Gitsigns toggle_linehl<CR>"}, {desc = "Toggle word diff", "<Leader>gTw", "<Cmd>Gitsigns toggle_word_diff<CR>"}, {desc = "Toggle current line blame", "<Leader>gTb", "<Cmd>Gitsigns toggle_current_line_blame<CR>"}, {desc = "Toggle deleted", "<Leader>gTd", "<Cmd>Gitsigns toggle_deleted<CR>"}, {desc = "Jump to next hunk", "<Leader>g]", "<Cmd>Gitsigns next_hunk<CR>"}, {desc = "Jump to previous hunk", "<Leader>g[", "<Cmd>Gitsigns prev_hunk<CR>"}, {desc = "Stage hunk", "<Leader>gs", "<Cmd>Gitsigns stage_hunk<CR>"}, {desc = "Reset hunk", "<Leader>gr", "<Cmd>Gitsigns reset_hunk<CR>"}, {desc = "Undo stage hunk", "<Leader>gu", "<Cmd>Gitsigns undo_stage_hunk<CR>"}, {desc = "Stage buffer", "<Leader>gS", "<Cmd>Gitsigns stage_buffer<CR>"}, {desc = "Reset buffer", "<Leader>gR", "<Cmd>Gitsigns reset_buffer<CR>"}, {mode = "v", desc = "Stage selection", "<Leader>gs", _1_}, {mode = "v", desc = "Reset selection", "<Leader>gr", _2_}, {desc = "Blame line", "<Leader>gB", _3_}, {desc = "Diff this", "<Leader>gd", "<Cmd>Gitsigns diffthis<CR>"}}, opts = {on_attach = _4_}, config = _6_, "lewis6991/gitsigns.nvim"}}