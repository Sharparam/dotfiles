-- :fennel:1725189909
local function _1_()
  local bufferline = require("bufferline")
  local icons = require("config.icons")
  local diag = {error = icons.diagnostics.Error, warning = icons.diagnostics.Warn, hint = icons.diagnostics.Hint, info = icons.diagnostics.Info}
  local diag_fb = icons.diagnostics.Info
  local function _2_(_count, _level, diagnostics_dict, _context)
    local s = " "
    for e, n in pairs(diagnostics_dict) do
      s = (s .. n .. (diag[e] or diag_fb))
    end
    return s
  end
  return {options = {mode = "buffers", style_preset = {bufferline.style_preset.no_italic}, themable = true, numbers = "both", middle_mouse_command = "bdelete! %d", diagnostics = "nvim_lsp", diagnostics_indicator = _2_, offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center", highlight = "Directory", separator = true}}, color_icons = true, show_buffer_icons = true, show_tab_indicators = true, show_duplicate_prefix = true, separator_style = "thin", hover = {enabled = true, delay = 200, reveal = {"close"}}, show_buffer_close_icons = false, show_close_icon = false}, highlights = require("catppuccin.groups.integrations.bufferline").get()}
end
local function _3_(_, opts)
  return require("bufferline").setup(opts)
end
local function _4_()
  local icons = require("config.icons")
  local utils = require("utils")
  local colors = {[""] = utils.fg("Special"), Normal = utils.fg("Special"), Warning = utils.fg("DiagnosticError"), InProgress = utils.fg("DiagnosticWarn")}
  local function _5_()
    return require("nvim-navic").get_location()
  end
  local function _6_()
    return (package.loaded["nvim-navic"] and require("nvim-navic").is_available())
  end
  local function _7_()
    local noice = require("noice")
    return noice.api.status.command.get()
  end
  local function _8_()
    local function _9_()
      local noice = require("noice")
      return noice.api.status.command.has()
    end
    return (package.loaded.noice and _9_())
  end
  local function _10_()
    local noice = require("noice")
    return noice.api.status.mode.get()
  end
  local function _11_()
    local function _12_()
      local noice = require("noice")
      return noice.api.status.mode.has()
    end
    return (package.loaded.noice and _12_())
  end
  local function _13_()
    local cpa = require("copilot.api")
    return (icons.kinds.Copilot .. (cpa.status.data.message or ""))
  end
  local function _14_()
    local ok, clients = pcall(vim.lsp.get_active_clients, {name = "copilot", bufnr = 0})
    return (ok and (#clients > 0))
  end
  local function _15_()
    if not package.loaded.copilot then
      return
    else
    end
    local cpa = require("copilot.api")
    return (colors[cpa.status.data.status] or colors[""])
  end
  local function _17_()
    return ("\239\145\175  " .. require("dap").status())
  end
  local function _18_()
    return (package.loaded.dap and (require("dap").status() ~= ""))
  end
  return {options = {theme = "catppuccin", globalstatus = true, disabled_filetypes = {statusline = {"dashboard", "alpha"}}}, sections = {lualine_a = {"mode"}, lualine_b = {{"branch", separator = ""}, {"diff", symbols = {added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed}}}, lualine_c = {{"diagnostics", symbols = {error = icons.diagnostics.Error, warn = icons.diagnostics.Warn, info = icons.diagnostics.Info}}, {"filetype", icon_only = true, separator = "", padding = {left = 1, right = 0}}, {"filename", path = 1, symbols = {modified = " \239\131\182 ", readonly = "", unnamed = ""}}, {_5_, cond = _6_}}, lualine_x = {{_7_, cond = _8_, color = utils.fg("Statement")}, {_10_, cond = _11_, color = utils.fg("Constant")}, {_13_, cond = _14_, color = _15_}, {_17_, cond = _18_, color = utils.fg("Debug")}, {require("lazy.status").updates, cond = require("lazy.status").has_updates, color = utils.fg("Special")}}, lualine_y = {{"encoding", separator = ""}, "fileformat"}, lualine_z = {{"progress", separator = " ", padding = {left = 1, right = 0}}, {"location", padding = {left = 0, right = 1}}}}, extensions = {"lazy"}}
end
local function _19_(_, opts)
  local telescope = require("telescope")
  telescope.setup()
  return telescope.load_extension("notify")
end
local function _20_(_, opts)
  return require("notify").setup(opts)
end
return {{"akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", event = "VeryLazy", cond = not vim.g.vscode, keys = {{"<Leader>bP", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin"}, {"<Leader>bU", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete unpinned buffers"}, {"<Leader>bb", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer"}, {"<Leader>bD", "<Cmd>BufferLinePickClose<CR>", desc = "Pick buffer to close"}}, opts = _1_, config = _3_}, {"nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons", event = "VeryLazy", cond = not vim.g.vscode, opts = _4_}, {"nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope-symbols.nvim"}, cond = not vim.g.vscode, keys = {{"<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files"}, {"<leader>.", "<Leader>ff", desc = "Find files", remap = true}, {"<leader>gff", "<cmd>Telescope git_files<cr>", desc = "Find Git file"}, {"<leader><leader>", "<cmd>Telescope git_files<cr>", desc = "Find file in project"}, {"<leader>sd", "<cmd>Telescope live_grep<cr>", desc = "Search CWD"}, {"<leader>bB", "<cmd>Telescope buffers<cr>", desc = "List buffers"}, {"<leader>sm", "<cmd>Telescope marks<cr>", desc = "List marks"}, {"<leader><cr>", "<cmd>Telescope marks<cr>", desc = "List marks"}, {"<leader>hn", "<cmd>Telescope notify<cr>", desc = "List notifications"}, {"<leader>cj", "<cmd>Telescope treesitter<cr>", desc = "List treesitter objects"}, {"<leader>clGb", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbols in buffer"}, {"<leader>clGc", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "List incoming calls"}, {"<leader>clGC", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "List outgoing calls"}, {"<leader>clGe", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Show diagnostics"}, {"<leader>clGE", "<cmd>Telescope diagnostics<cr>", desc = "Show all diagnostics"}, {"<leader>clGg", "<cmd>Telescope lsp_definitions<cr>", desc = "Find definitions"}, {"<leader>clGi", "<cmd>Telescope lsp_implementations<cr>", desc = "Find implementations"}, {"<leader>clGr", "<cmd>Telescope lsp_references<cr>", desc = "Find references"}, {"<leader>clGs", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Find symbols in workspace"}, {"<leader>clGS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find symbols in workspace (dynamic)"}, {"<leader>clGt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Find type definitions"}, {"<leader>hbB", "<cmd>Telescope keymaps<cr>", desc = "List normal keymaps"}, {"<leader>ib", "<cmd>Telescope builtin<cr>", desc = "Built-in pickers"}, {"<leader>id", "<cmd>Telescope symbols<cr>", desc = "Symbols from data"}, {"<leader>iP", "<cmd>Telescope planets<cr>", desc = "Planets"}}, config = _19_}, {"stevearc/oil.nvim", dependencies = "nvim-tree/nvim-web-devicons", cond = not vim.g.vscode, opts = {columns = {"permissions", "siz", "mtime", "icon"}}}, {"nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons", cond = not vim.g.vscode, keys = {{"<Leader>op", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle tree"}, {"<Leader>oP", "<Cmd>NvimTreeFindFile<CR>", desc = "Find file in tree"}}, opts = {}}, {"stevearc/dressing.nvim", cond = not vim.g.vscode, opts = {}}, {"folke/noice.nvim", dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}, cond = not vim.g.vscode, opts = {lsp = {override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true}}, presets = {bottom_search = true, command_palette = true, long_message_to_split = true, inc_rename = false, lsp_doc_border = false}}}, {"folke/trouble.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}, cond = not vim.g.vscode, keys = {{"<Leader>cxx", "<Cmd>TroubleToggle<CR>", desc = "Diagnostics"}, {"<Leader>cxw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace diagnostics"}, {"<Leader>cxd", "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document diagnostics"}, {"<Leader>cxq", "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix items"}, {"<Leader>cxl", "<Cmd>TroubleToggle loclist<CR>", desc = "Items from location list"}}, opts = {}}, {"rcarriga/nvim-notify", cond = not vim.g.vscode, main = "notify", opts = {render = "compact"}, config = _20_}, {"Bekaboo/deadcolumn.nvim", cond = not vim.g.vscode, opts = {scope = "line", modes = {"niI", "niR", "niV", "i", "ic", "ix", "R", "Rc", "Rx", "Rv", "Rvc", "Rvx"}, blending = {threshold = 0.75, colorcode = "#000000", hlgroup = {"Normal", "background"}}, warning = {alpha = 0.4, offset = 0, colorcode = "#FF0000", hlgroup = {"Error", "foreground"}}, extra = {follow_tw = "+1"}}}}