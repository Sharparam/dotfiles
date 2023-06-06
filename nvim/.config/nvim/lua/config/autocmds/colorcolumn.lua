local config = {
  cs = '120',
  gitcommit = { '50', '72' },
  lua = '80',
  markdown = '80',
  ruby = '80'
}

for lang, opt in pairs(config) do
  local opt_desc = opt
  if type(opt_desc) == 'table' then
    opt_desc = '[' .. table.concat(opt_desc, ', ') .. ']'
  end
  vim.api.nvim_create_autocmd(
    'FileType',
    {
      pattern = lang,
      callback = function()
        vim.opt_local.colorcolumn = opt
      end,
      desc = 'Set colorcolumn for ' .. lang .. ' files to ' .. opt_desc
    }
  )
end
