local o = vim.o -- globals options
local w = vim.wo -- window local options
local b = vim.bo -- buffer local options
local g = vim.g -- global variables

local utils = require 'utils'

require 'plugins'

vim.g.mapleader = ' '

b.autoindent = true
b.expandtab = true
b.softtabstop = 4
b.shiftwidth = 4
b.tabstop = 4
b.smartindent = true
b.modeline = true
o.hlsearch = true
o.incsearch = true
o.showmatch = true

o.backspace = [[indent,eol,start]]
o.hidden = true
w.winfixwidth = true

o.lazyredraw = true

o.splitbelow = true
o.splitright = true

w.cursorline = true
b.synmaxcol = 4000

w.number = true
w.relativenumber = true

w.list = true
if vim.fn.has('multi_byte') == 1 and vim.o.encoding == 'utf-8' then
  o.listchars = [[tab:▸ ,lead:·,extends:❯,precedes:❮,nbsp:±,trail:·]]
else
  o.listchars = [[tab:> ,lead:.,extends:>,precedes:<,nbsp:.,trail:_]]
end

w.colorcolumn = [[80,120]]
w.wrap = false

o.termguicolors = true

o.clipboard = [[unnamed,unnamedplus]]

o.scrolloff = 4

o.timeoutlen = 300

o.mouse = 'a'

o.completeopt = [[menuone,noinsert,noselect]]

o.errorbells = false
o.visualbell = false

utils.create_augroup({
  { 'BufEnter,FocusGained,InsertLeave', '*', 'set relativenumber' },
  { 'BufLeave,FocusLost,InsertEnter', '*', 'set norelativenumber' }
}, 'numbertoggle')

o.background = 'dark'
vim.cmd [[colorscheme codedark]]
g.airline_theme = 'codedark'

-- Disable arrow keys
-- for _, key in pairs({ '<Left>', '<Right>', '<Up>', '<Down>' }) do
--   utils.map('', key, '', { noremap = true })
--   utils.map('i', key, '', { noremap = true })
-- end
