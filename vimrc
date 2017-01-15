"let $PYTHONPATH='/usr/lib/python3.5/site-packages'
let g:powerline_pycmd='py3'

let mapleader=' '

set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'chriskempson/base16-vim'
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

set cul

" Always show ruler
"set ruler

set cmdheight=1

" Better backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set hlsearch " Highlight search results
set incsearch " Search behaves like browser

set lazyredraw " Don't redraw during macros

set showmatch

set noerrorbells
set novisualbell

""""""""""""""""""""
" Colors and fonts "
""""""""""""""""""""

syntax enable

set background=dark
let base16colorspace=256
colorscheme base16-eighties
"hi ColorColumn ctermbg=237
"hi LineNr ctermbg=237
"hi CursorLine ctermbg=237
"hi CursorLineNr ctermbg=237

set encoding=utf8

if &term =~ '256color'
  set t_ut=
endif

nmap <leader>- :source ~/.vimrc<CR>:redraw!<CR>:echo "~/.vimrc reloaded"<CR>
