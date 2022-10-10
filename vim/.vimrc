let mapleader=' '

let g:airline_theme='base16_eighties'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

set nocompatible " be iMproved, required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'rhysd/vim-crystal'
call plug#end()

set tabstop=4
set shiftwidth=4
set expandtab

set laststatus=2
set t_Co=256
set noshowmode

set nu rnu " Display line numbers

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

set autoread " Auto-reload files on external change

set showcmd

if hostname() != 'PC490' && hostname() != 'Sharparam-PC'
  set cul
endif

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

set background=dark
if hostname() != 'PC490' && hostname() != 'Sharparam-PC'
  let base16colorspace=256
endif
colorscheme base16-eighties

set encoding=utf8

if &term =~ '256color'
  set t_ut=
endif

nmap <leader>- :source ~/.vimrc<CR>:redraw!<CR>:echo "~/.vimrc reloaded"<CR>

nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>

vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>

inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
