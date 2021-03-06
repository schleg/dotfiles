call pathogen#infect()

set encoding=utf-8

" https://github.com/kien/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_working_path_mode=''

" Use vim settings, not vi
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

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the cursor position all the time
set ruler

" Display incomplete commands
set showcmd

syntax on
syntax enable
set background=dark

" http://ethanschoonover.com/solarized
let g:solarized_termtrans = 1
colorscheme solarized

set cursorline

set number

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

  autocmd GUIEnter * set vb t_vb=
  autocmd GUIEnter * set guifont=Pragmata:h14

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Sane editing configuration
set autoindent
set laststatus=2
set showmatch
set incsearch
set softtabstop=2
set nowrap
set hls
set tabstop=2 shiftwidth=2 expandtab

if has("mouse")
  set mouse=a
endif

"autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

set colorcolumn=80
hi ColorColumn guibg=DarkGray

highlight ExtraWhitespace ctermbg=DarkGray guibg=DarkGray

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

" enable single-click
let NERDTreeMouseMode = 2

let g:jsx_ext_required = 0

au BufRead,BufNewFile *.slim set filetype=slim
au! Syntax slim source "$VIM/syntax.slim.vim"

" Mouse support in tmux
set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

let g:ackprg = 'ag --nogroup --nocolor --column'

let g:vimrubocop_config = './.rubocop.yml'
let g:syntastic_ruby_rubocop_exec = '/Users/tyler/.rbenv/shims/ruby /Users/tyler/.rbenv/shims/rubocop'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:tsuquyomi_completion_detail = 1
set omnifunc=syntaxcomplete#Complete

autocmd! GUIEnter * set vb t_vb=
autocmd! GUIEnter * set guifont=Pragmata:h14

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

autocmd BufWritePre * %s/\s\+$//e
