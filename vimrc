"let $PYTHONPATH='/usr/lib/python3.5/site-packages'
let g:powerline_pycmd='py3'

set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
""Plugin 'AutoClose'
" Plugin 'Valloric/YouCompleteMe'

call vundle#end()

filetype plugin indent on

set tabstop=4
set shiftwidth=4
set expandtab

set laststatus=2
set t_Co=256
set noshowmode
set showtabline=2

set nu " Display line numbers
set autoread " Auto-reload files on external change

set showcmd

"set mouse=a

set cul
hi CursorLine term=none cterm=none ctermbg=3

" WiLd menu (autocomplete)
set wildmenu
set wildignore=*.o,*~,*.pyc,*.out

" Always show ruler
set ruler

set cmdheight=1

" Better backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set hlsearch " Highlight search results
set incsearch " Search behaves like browser

set lazyredraw " Don't redraw during macros

set magic " For RegEx

set showmatch
set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""
" Colors and fonts "
""""""""""""""""""""

syntax enable

colorscheme desert
set background=dark

set encoding=utf8

set ffs=unix,dos,mac

"""""""""""""""""""""""
" Visual mode related "
"""""""""""""""""""""""

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""
" Status line "
"""""""""""""""

"set laststatus=2

"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

""""""""""""""""""""
" Editing mappings "
""""""""""""""""""""

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
