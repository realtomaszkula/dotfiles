set nocompatible              " required
filetype off                  " required
filetype plugin indent on    " required
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'vim-scripts/matchit.zip.git'
Plugin 'kana/vim-textobj-user.git'
Plugin 'nelstrom/vim-textobj-rubyblock.git'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'thoughtbot/vim-rspec.git'
Plugin 'szw/vim-g'
Plugin 'tpope/vim-bundler.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rake.git'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/rbenv-ctags'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-git'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'christoomey/vim-conflicted'
Plugin 'christoomey/vim-system-copy'
Plugin 'suan/vim-instant-markdown'
Plugin 'derekprior/vim-trimmer'
Plugin 'itchyny/lightline.vim'
Plugin 'duggiefresh/vim-easydir'
Plugin 'airblade/vim-gitgutter'
Plugin 'kana/vim-textobj-entire'

call vundle#end()            " required

inoremap jj <Esc>
let mapleader = " "

" My own bindings
nnoremap <leader>w :w<Cr>
nnoremap <leader>q :q<Cr>
:nnoremap <F5> :buffers<CR>:buffer<Space>

" Relative numbers
set relativenumber
set number
autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set relativenumber


" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>


" Search highlight
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" enters in normal mode
nmap oo o<Esc>k
nmap OO O<Esc>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
      \ {"regex": "possibly useless use of a variable in void context"}

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

"ignore case if its all lower case, but recognize case if its upper case
set ignorecase
set smartcase

"search path
set path=.,,**

" add commandline completion
set wildmenu

"walking on non existing sections
set virtualedit=all

" ctrl+p
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Status Line
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

"NERDTree
let NERDTreeShowHidden=1

" rspec vim
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>:
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "VtrSendCommandToRunner! rspec {spec}"

" vim-tmux-runner
let g:VtrOrientation = "h"
let g:VtrUseVtrMaps = 1

" vim-conflicted
let g:diffget_local_map = 'dgl'
let g:diffget_upstream_map = 'dgu'
set stl+=%{ConflictedVersion()}

" bind K to grep under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" format entire file and go back to prev line
nnoremap <leader>ff gg=G``

