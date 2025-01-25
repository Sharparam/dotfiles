-- :fennel:1686260659
local M = {}
local cmd = vim.cmd
local is_wsl
do
  local output = vim.fn.systemlist("uname -r")
  is_wsl = not not string.find((output[1] or ""), "WSL")
end
M["is-wsl"] = is_wsl
M["create-augroup"] = function(autocmds, name)
  cmd(("augroup " .. name))
  cmd("autocmd!")
  for _, autocmd in ipairs(autocmds) do
    cmd(("autocmd " .. table.concat(autocmd, " ")))
  end
  return cmd("augroup END")
end
M["add-rtp"] = function(path)
  vim.o.rtp = (vim.o.rtp .. "," .. path)
  return nil
end
M.map = function(mode, keys, action, options)
  return vim.api.nvim_set_keymap(mode, keys, action, (options or {}))
end
M["map-lua"] = function(mode, keys, action, options)
  return vim.api.nvim_set_keymap(mode, keys, ("<Cmd>lua " .. action .. "<CR>"), (options or {}))
end
M["map-buf"] = function(mode, keys, action, options, buf_nr)
  local buf = (buf_nr or 0)
  return vim.api.nvim_buf_set_keymap(buf, mode, keys, action, (options or {}))
end
M["map-lua-buf"] = function(mode, keys, action, options, buf_nr)
  local buf = (buf_nr or 0)
  return vim.api.nvim_buf_set_keymap(buf, mode, keys, ("<Cmd>lua " .. action .. "<CR>"), (options or {}))
end
M["on-attach"] = function(on_attach)
  local function _1_(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    return on_attach(client, buffer)
  end
  return vim.api.nvim_create_autocmd("LspAttach", {callback = _1_})
end
M.has = function(plugin)
  local config = require("lazy.core.config")
  return (nil ~= config.plugins[plugin])
end
M.fg = function(name)
  local hl = ((vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, {name = name})) or vim.api.nvim_get_hl_by_name(name, true))
  local fg = ((hl and hl.fg) or hl.foreground)
  return (fg and {fg = string.format("#%06x", fg)})
end
_G.utils = M
return M