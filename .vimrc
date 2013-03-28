call pathogen#infect()

" https://github.com/kien/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Use Vim settings, rather then Vi settings
" This must be first because it changes other options as a side effect.
set nocompatible

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Remember more commands and search history
set history=1000

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

let slim = "$VIM/syntax/slim.vim"

syntax on
syntax enable
set background=dark

" http://ethanschoonover.com/solarized 
let g:solarized_termtrans = 1
colorscheme solarized

set cursorline

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Sane editing configuration
set expandtab
set autoindent
set laststatus=2
set showmatch
set incsearch
set softtabstop=2
set shiftwidth=2
set tabstop=2

set hls

if has("mouse")
  set mouse=a
endif

"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

set colorcolumn=80
hi ColorColumn guibg=DarkGray 

autocmd filetype css setlocal equalprg=csstidy\ -\ --silent=true

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

map <Esc>[B <Down>

nnoremap <F3> :NumbersToggle<CR>

" https://github.com/shougo/neocomplcache
let g:neocomplcache_enable_at_startup = 1

" enable single-click
let NERDTreeMouseMode = 2

" https://github.com/Lokaltog/vim-easymotion
let g:EasyMotion_leader_key = '<Leader>'

au BufRead,BufNewFile *.slim set filetype=slim
au! Syntax slim source "$VIM/syntax.slim.vim"
