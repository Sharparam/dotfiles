-- :fennel:1725200162
local wanted_servers = {"ansiblels", "bicep", "dockerls", "docker_compose_language_service", "fennel_language_server", "html", "jsonls", "tsserver", "lua_ls", "perlnavigator", "raku_navigator", "solargraph", "rust_analyzer", "taplo", "vimls", "lemminx", "yamlls"}
local function _1_(_, opts)
  local copilot_cmp = require("copilot_cmp")
  local utils = require("utils")
  copilot_cmp.setup(opts)
  local function _2_(client)
    if (client.name == "copilot") then
      return copilot_cmp._on_insert_enter({})
    else
      return nil
    end
  end
  return utils["on-attach"](_2_)
end
local function _4_()
  if (jit.os):find("Windows") then
    return nil
  else
    return "echo \"NOTE: jsregexp optional, failure to build is OK\"; make install_jsregexp"
  end
end
local function _6_(_, opts)
  local lsp = require("lsp-zero")
  local cmp = require("cmp")
  local function _7_(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    local map
    local function _8_(m, l, r, d)
      return vim.keymap.set(m, l, r, {buffer = bufnr, desc = d})
    end
    map = _8_
    return map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
  end
  lsp.extend_lspconfig({capabilities = require("cmp_nvim_lsp").default_capabilities(), lsp_attach = _7_, float_border = "rounded"})
  lsp.format_mapping("gq", {format_opts = {async = true, timeout_ms = 10000}, servers = {["null-ls"] = {"javascript", "typescript", "lua", "fennel", "ruby", "c", "cpp", "rust", "py", "sh", "bash", "zsh"}}})
  require("mason").setup()
  require("mason-null-ls").setup({ensure_installed = wanted_servers, handlers = {}, automatic_installation = false})
  do
    local null_ls = require("null-ls")
    null_ls.setup({sources = {}})
  end
  require("luasnip.loaders.from_vscode").lazy_load()
  local cmp_actions = lsp.cmp_action()
  local function _9_(args)
    return require("luasnip").lsp_expand(args.body)
  end
  local function _10_(entry, item)
    do
      local icons = require("config.icons").kinds
      if icons[item.kind] then
        item.kind = (icons[item.kind] .. item.kind)
      else
      end
    end
    do
      local smap = {buffer = "[BUF]", nvim_lsp = "[LSP]", luasnip = "[SNP]", nvim_lua = "[LUA]", latex_symbols = "[LTX]", path = "[PTH]", cmdline = "[CMD]", copilot = "[COP]", conjure = "[CNJ]"}
      item.menu = smap[entry.source.name]
    end
    return item
  end
  return cmp.setup({snippet = {expand = _9_}, mapping = {["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}), ["<C-p>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}), ["<C-u>"] = cmp.mapping.scroll_docs(-4), ["<C-d>"] = cmp.mapping.scroll_docs(4), ["<CR>"] = cmp.mapping.confirm({select = false}), ["<S-CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false}), ["<Tab>"] = cmp.mapping.confirm({select = true}), ["<S-Tab>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}), ["<C-Space>"] = cmp.mapping.complete(), ["<C-e>"] = cmp.mapping.abort(), ["<C-f>"] = cmp_actions.luasnip_jump_forward(), ["<C-b>"] = cmp_actions.luasnip_jump_backward()}, sources = cmp.config.sources({{name = "copilot", group_index = 2}, {name = "conjure"}, {name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}, {name = "path"}, {name = "cmdline"}}), sorting = {priority_weight = 2, comparators = {require("copilot_cmp.comparators").prioritize, cmp.config.compare.offset, cmp.config.compare.exact, cmp.config.compare.score, cmp.config.compare.recently_used, cmp.config.compare.locality, cmp.config.compare.kind, cmp.config.compare.sort_text, cmp.config.compare.length, cmp.config.compare.order}}, formatting = {format = _10_}}, "experimental", {ghost_text = {hl_group = "NonText"}})
end
return {{"VonHeikemen/lsp-zero.nvim", branch = "v4.x", cond = not vim.g.vscode, dependencies = {{"neovim/nvim-lspconfig"}, {"williamboman/mason.nvim", build = ":MasonUpdate", cmd = "Mason", config = true}, {"williamboman/mason-lspconfig.nvim", dependencies = "williamboman/mason.nvim"}, {"hrsh7th/nvim-cmp", dependencies = {{"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"}, {"L3MON4D3/LuaSnip"}, {"saadparwaiz1/cmp_luasnip"}, {"PaterJason/cmp-conjure"}}, version = false}, {"hrsh7th/cmp-nvim-lsp"}, {"zbirenbaum/copilot.lua", build = ":Copilot auth", cmd = "Copilot", opts = {suggestion = {enabled = false}, panel = {enabled = false}}}, {"zbirenbaum/copilot-cmp", dependencies = "zbirenbaum/copilot.lua", main = "copilot_cmp", opts = {}, config = _1_}, {"L3MON4D3/LuaSnip", build = _4_}, {"rafamadriz/friendly-snippets"}, {"folke/neoconf.nvim", config = true}, {"folke/neodev.nvim", dependencies = "hrsh7th/nvim-cmp", opts = {}}, {"nvimtools/none-ls.nvim", dependencies = "williamboman/mason.nvim"}, {"jay-babu/mason-null-ls.nvim", event = {"BufReadPre", "BufNewFile"}, dependencies = {"williamboman/mason.nvim", "nvimtools/none-ls.nvim"}}}, config = _6_}}