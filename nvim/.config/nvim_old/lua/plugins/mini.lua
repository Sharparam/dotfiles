-- :fennel:1686673977
local function _1_()
  local indentscope = require("mini.indentscope")
  return {draw = {animation = indentscope.gen_animation.none()}}
end
local function _2_()
  return (require("mini.trailspace")).trim()
end
local function _3_()
  return (require("mini.trailspace")).trim_last_lines()
end
return {{config = true, version = false, "echasnovski/mini.ai"}, {config = true, version = false, "echasnovski/mini.bracketed"}, {config = true, version = false, "echasnovski/mini.bufremove"}, {cond = not vim.g.vscode, opts = _1_, version = false, "echasnovski/mini.indentscope"}, {config = true, version = false, "echasnovski/mini.pairs"}, {opts = {mappings = {add = "gza", delete = "gzd", find = "gzf", find_left = "gzF", highlight = "gzh", replace = "gzr", update_n_lines = "gzn", suffix_last = "l", suffix_next = "n"}}, version = false, "echasnovski/mini.surround"}, {keys = {[{desc = "Trim trailing whitespace", "<Leader>cw", _2_}] = {desc = "Trim trailing empty lines", "<Leader>cW", _3_}}, version = false, "echasnovski/mini.trailspace"}}