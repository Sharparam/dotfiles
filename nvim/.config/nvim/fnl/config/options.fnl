(local o vim.o)
(local w vim.wo)
(local b vim.bo)
(local g vim.g)

(set o.hlsearch true)
(set o.incsearch true)
(set o.showmatch true)

(set o.backspace "indent,eol,start")
(set o.hidden true)

(set o.lazyredraw true)

(set o.splitbelow true)
(set o.splitright true)

(if (and (= (vim.fn.has :multi_byte) 1) (= o.encoding :utf-8))
  (set o.listchars "tab:▸ ,lead:·,extends:❯,precedes:❮,nbsp:±,trail:·")
  (set o.listchars "tab:> ,lead:.,extends:>,precedes:<,nbsp:.,trail:_"))

(set o.clipboard "unnamed,unnamedplus")

(set o.scrolloff 4)

(set o.timeoutlen 300)

(set o.mouse :a)

(set o.completeopt "menuone,noinsert,noselect")

(set o.errorbells false)
(set o.visualbell false)

(set w.winfixwidth true)

(set w.number true)
(set w.relativenumber true)
(set w.list true)
(set w.cursorline true)
(set w.colorcolumn "80,120")
(set w.wrap false)

(set b.synmaxcol 4000)
(set b.autoindent true)
(set b.expandtab true)
(set b.softtabstop 4)
(set b.shiftwidth 4)
(set b.tabstop 4)
(set b.smartindent true)
(set b.modeline true)
