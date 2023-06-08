---@class BootstrapOptions
---@field ref string? Git ref to checkout
---@field name string? Name of the plugin
---@field path string? Path to clone to
---@field adjust_rtp boolean? Whether to adjust the runtimepath

--- Bootstraps a plugin by cloning it into the data dir
---@param url string Git URL to clone
---@param opts BootstrapOptions Options
---@return string path path to the installed plugin
local function bootstrap(url, opts)
  local name = opts.name or url:gsub(".*/(.+)%.git", "%1") or url:gsub(".*/", "")
  local path = opts.path or (vim.fn.stdpath("data") .. "/lazy/" .. name)

  if vim.loop.fs_stat(path) then
    if opts.adjust_rtp then vim.opt.rtp:prepend(path) end
    return path
  end

  print(name .. ": installing in data dir...")

  local cmd = { "git", "clone", "--filter=blob:none", url, path }
  if opts.ref then table.insert(cmd, 4, "--branch=" .. opts.ref) end

  vim.fn.system(cmd)

  if opts.adjust_rtp then vim.opt.rtp:prepend(path) end

  vim.cmd "redraw"
  print(name .. ": finished installing")

  return path
end

bootstrap("https://github.com/folke/lazy.nvim.git", { ref = "stable", adjust_rtp = true })
bootstrap("https://github.com/udayvir-singh/tangerine.nvim.git", { ref = "v2.4", adjust_rtp = true })
bootstrap("https://github.com/udayvir-singh/hibiscus.nvim.git", { ref = "v1.5", adjust_rtp = true })

-- vim.opt.rtp:prepend(lazy_path)

require("tangerine").setup {
  compiler = {
    verbose = false,
    hooks = { "onsave", "oninit" }
  }
}
