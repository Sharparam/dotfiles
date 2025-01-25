-- :fennel:1686258610
local o = vim.o
local w = vim.wo
local b = vim.bo
local g = vim.g
o.hlsearch = true
o.incsearch = true
o.showmatch = true
o.backspace = "indent,eol,start"
o.hidden = true
o.lazyredraw = true
o.splitbelow = true
o.splitright = true
if ((vim.fn.has("multi_byte") == 1) and (o.encoding == "utf-8")) then
  o.listchars = "tab:\226\150\184 ,lead:\194\183,extends:\226\157\175,precedes:\226\157\174,nbsp:\194\177,trail:\194\183"
else
  o.listchars = "tab:> ,lead:.,extends:>,precedes:<,nbsp:.,trail:_"
end
o.clipboard = "unnamed,unnamedplus"
o.scrolloff = 4
o.timeoutlen = 300
o.mouse = "a"
o.completeopt = "menuone,noinsert,noselect"
o.errorbells = false
o.visualbell = false
w.winfixwidth = true
w.number = true
w.relativenumber = true
w.list = true
w.cursorline = true
w.colorcolumn = "80,120"
w.wrap = false
b.synmaxcol = 4000
b.autoindent = true
b.expandtab = true
b.softtabstop = 4
b.shiftwidth = 4
b.tabstop = 4
b.smartindent = true
b.modeline = true
return nil