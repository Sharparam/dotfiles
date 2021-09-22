local M = {}
local cmd = vim.cmd

function M.create_augroup(autocmds, name)
  cmd('augroup ' .. name)
  cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  cmd('augroup END')
end

function M.add_rtp(path)
  local rtp = vim.o.rtp
  rtp = rtp .. ',' .. path
end

function M.map(mode, keys, action, options)
  if options == nil then
    options = {}
  end
  vim.api.nvim_set_keymap(mode, keys, action, options)
end

function M.map_lua(mode, keys, action, options)
  if options == nil then
    options = {}
  end
  vim.api.nvim_set_keymap(mode, keys, '<cmd>lua ' .. action .. '<cr>', options)
end

function M.map_buf(mode, keys, action, options, buf_nr)
  if options == nil then
    options = {}
  end
  local buf = buf_nr or 0
  vim.api.nvim_buf_set_keymap(buf, mode, keys, action, options)
end

function M.map_lua_buf(mode, keys, action, options, buf_nr)
  if options == nil then
    options = {}
  end
  local buf = buf_nr or 0
  vim.api.nvim_buf_set_keymap(buf, mode, keys, '<cmd>lua ' .. action .. '<cr>', options)
end

_G.utils = M
return M
