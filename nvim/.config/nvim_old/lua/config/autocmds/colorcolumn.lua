-- :fennel:1686258610
local config = {cs = "120", gitcommit = {"50", "72"}, lua = "80", markdown = "80", ruby = "80"}
for lang, opt in pairs(config) do
  local opt_desc
  if (type(opt) == "table") then
    opt_desc = ("[" .. table.concat(opt, ", ") .. "]")
  else
    opt_desc = opt
  end
  local function _2_()
    vim.opt_local.colorcolumn = opt
    return nil
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = lang, callback = _2_, desc = ("Set colorcolumn for " .. lang .. " files to " .. opt_desc)})
end
return nil