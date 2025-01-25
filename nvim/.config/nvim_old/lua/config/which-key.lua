-- :fennel:1725156496
local wk = require("which-key")
local function flatten(...)
  local r = {}
  for _, v in ipairs({...}) do
    for _0, iv in ipairs(v) do
      table.insert(r, iv)
    end
  end
  return r
end
local function merge(a, b)
  if (type(b) == "table") then
    for k, v in pairs(b) do
      a[k] = v
    end
    return nil
  else
    return nil
  end
end
local function group(key, name, opts, ...)
  local bindings = {{key, group = name}}
  merge(bindings[1], opts)
  for _, sub in ipairs(flatten(...)) do
    sub[1] = (key .. sub[1])
    table.insert(bindings, sub)
  end
  return bindings
end
local function bind(key, cmd, desc, opts)
  local binding = {{key, cmd, desc = desc}}
  merge(binding[1], opts)
  return binding
end
local function desc(key, desc0)
  return {{key, desc = desc0}}
end
local function _2_()
  return vim.lsp.buf.format({async = true})
end
local function _3_()
  return vim.lsp.buf.format({async = true})
end
wk.add(flatten(group("<Leader>b", "+buffer", nil, bind("[", "<Cmd>bprevious<CR>", "Previous buffer"), bind("p", "<Cmd>bprevious<CR>", "Previous buffer"), bind("]", "<Cmd>bnext<CR>", "Next buffer"), bind("n", "<Cmd>bnext<CR>", "Next buffer"), bind("d", "<Cmd>bdelete<CR>", "Kill buffer"), bind("k", "<Cmd>bdelete<CR>", "Kill buffer"), bind("K", "<Cmd>%bdelete<CR>", "Kill all buffers"), bind("s", "<Cmd>w<CR>", "Save buffer"), bind("S", "<Cmd>wa<CR>", "Save all buffers"), bind("u", "<Cmd>w !sudo tee \"%\"<CR>", "Save buffer as root"), bind("y", "<Cmd>%y<CR>", "Yank buffer")), group("<Leader>c", "+code", nil, bind("d", vim.lsp.buf.definition, "Jump to definition"), bind("D", vim.lsp.buf.references, "Jump to references"), bind("f", _2_, "Format buffer"), bind("i", vim.lsp.buf.implementation, "Find implementations"), bind("k", vim.lsp.buf.hover, "Show help"), group("l", "+lsp", nil, group("=", "+formatting", nil, bind("=", _3_, "Format buffer")), group("a", "+code actions", nil, bind("a", vim.lsp.buf.code_action, "Code actions")), group("d", "+diagnostics", nil, bind("l", vim.diagnostic.open_float, "Show diagnostics window"), bind("n", vim.diagnostic.goto_next, "Go to next diagnostic"), bind("p", vim.diagnostic.goto_prev, "Go to previous diagnostic")), group("f", "+folders", nil, bind("a", vim.lsp.buf.add_workspace_folder, "Add workspace folder"), bind("l", vim.lsp.buf.list_workspace_folders, "List workspace folders"), bind("r", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")), group("g", "+goto", nil, bind("a", vim.lsp.buf.workspace_symbol, "Find symbol in workspace"), bind("c", vim.lsp.buf.incoming_calls, "Find incoming calls"), bind("C", vim.lsp.buf.outgoing_calls, "Find outgoing calls"), bind("d", vim.lsp.buf.declaration, "Find declarations"), bind("g", vim.lsp.buf.definition, "Find definitions"), bind("i", vim.lsp.buf.implementation, "Find implementations"), bind("r", vim.lsp.buf.references, "Find references"), bind("t", vim.lsp.buf.type_definition, "Find type definition")), group("G", "+peek"), group("h", "+help", nil, bind("s", vim.lsp.buf.signature_help, "Show signature help")), group("r", "+refactor", nil, bind("r", vim.lsp.buf.rename, "Rename")), group("t", "+toggle", nil, bind("s", vim.lsp.buf.signature_help, "Show signature help"))), bind("r", vim.lsp.buf.rename, "Rename"), bind("t", vim.lsp.buf.type_definition, "Find type definition"), group("x", "+Trouble")), group("<Leader>f", "+file"), group("<Leader>g", "+git", nil, group("f", "+find"), group("T", "+toggle")), group("<Leader>h", "+help", nil, group("b", "+bindings", nil, bind("b", "<Cmd>WhichKey<CR>", "Show all mappings"))), group("<Leader>i", "+insert"), group("<Leader>o", "+open"), group("<Leader>s", "+search"), group("<Leader>w", "window", bind("+", "<C-w>+", "Increase height"), bind("-", "<C-w>-", "Decrease height"), bind("<", "<C-w><", "Decrease width"), bind("=", "<C-w>=", "Balance"), bind("_", "<C-w>_", "Set height"), bind(">", "<C-w>>", "Increase width"), bind("b", "<C-w>b", "Go to bottom"), bind("c", "<Cmd>close<CR>", "Close"), bind("C", "<Cmd>close!<CR>", "Close discard changes"), bind("d", "<C-w>d", "Split to definition"), bind("f", "<C-w>f", "Split to file"), bind("F", "<C-w>F", "Split to file:line"), group("g", "prefix", nil, bind("<C-]>", "<C-w>g<C-]>", "Split and tag jump"), bind("]", "<C-w>g]", "Split and tag select"), bind("}", "<C-w>g}", "Preview tag jump"), bind("f", "<C-w>gf", "Edit file in new tab page"), bind("F", "<C-w>gF", "Edit file:line in new tab page"), bind("t", "<Cmd>tabnext<CR>", "Next tab page"), bind("T", "<Cmd>tabprevious<CR>", "Previous tab page"), bind("<Tab>", "<Cmd>tablast<CR>", "Last accessed tab page")), bind("h", "<C-w>h", "Go left"), bind("H", "<C-w>H", "Move left"), bind("i", "<C-w>i", "Split to declaration"), bind("j", "<C-w>j", "Go down"), bind("J", "<C-w>J", "Move down"), bind("k", "<C-w>k", "Go up"), bind("K", "<C-w>K", "Move up"), bind("l", "<C-w>l", "Go right"), bind("n", "<C-w>n", "New"), bind("o", "<Cmd>only<CR>", "Close all but current"), bind("p", "<C-w>p", "Go to previous"), bind("P", "<C-w>P", "Go to preview"), bind("q", "<Cmd>quit<CR>", "Quit"), bind("Q", "<Cmd>quit!<CR>", "Quit discard changes"), bind("r", "<C-w>r", "Rotate downwards"), bind("R", "<C-w>R", "Rotate upwards"), bind("s", "<C-w>s", "Split horizontal"), bind("S", "<C-w>S", "Split horizontal"), bind("t", "<C-w>t", "Go to top"), bind("T", "<C-w>T", "Move to new tab page"), bind("v", "<C-w>v", "Split vertical"), bind("w", "<C-w>w", "Go to next (wrap around)"), bind("W", "<C-w>W", "Previous (wrap around)"), bind("x", "<C-w>x", "Exchange"), bind("z", "<C-w>z", "Close preview"), bind("}", "<C-w>}", "Show tag in preview"), bind("<Down>", "<C-w>j", "Go down"), bind("<Up>", "<C-w>k", "Go up"), bind("<Left>", "<C-w>h", "Go left"), bind("<Right>", "<C-w>l", "Go right"))))
wk.add(group("<Leader>g", "git", {mode = "v"}))
wk.add(flatten(desc("gt", "Next tab page"), desc("gT", "Previous tab page"), desc("g<Tab>", "Last accessed tab page")))
return wk.add(group("<C-w>g", "prefix", nil, desc("t", "Next tab page"), desc("T", "Previous tab page"), desc("<Tab>", "Last accessed tab page")))