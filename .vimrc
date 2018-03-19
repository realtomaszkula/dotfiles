set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim.git'
call vundle#end()            " required
filetype plugin indent on    " required

let mapleader = " "
nnoremap <leader>w :w<Cr>
nnoremap <leader>q :q<Cr>


" Numbers
set number
set relativenumber
set numberwidth=5

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Switch between last two files
nnoremap <leader><leader> <C-^>

" Ignore case if its all lower case, but recognize case if its upper case
set ignorecase
set smartcase

" Search path
set path=.,,**

" Add commandline completion
set wildmenu

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|git'


