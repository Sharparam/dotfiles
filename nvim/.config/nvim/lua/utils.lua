local M = {}
local cmd = vim.cmd

local is_wsl = (function()
  local output = vim.fn.systemlist 'uname -r'
  return not not string.find(output[1] or '', 'WSL')
end)()

M.is_wsl = is_wsl

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

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.has(plugin)
  return require('lazy.core.config').plugins[plugin] ~= nil
end

_G.utils = M
return M
