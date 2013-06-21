set nocompatible

call pathogen#infect()

syntax on
filetype plugin indent on

let mapleader=','

set t_Co=256

" set foldmethod=marker " | syntax
set foldmethod=syntax
set foldlevelstart=99
set foldnestmax=5
set foldclose=all

set title
set titlestring=%f

set backspace=indent,eol,start " backspace over everything

set tabstop=2     " size of a tab
set shiftwidth=2  " size for auto/smartindent
set softtabstop=2 " a tab is this size
set expandtab     " spaces not tabs
set smartindent   " indents for you
set nosmarttab    " tabs at start of lines
set autoindent    " always set autoindenting on

function! GitBranch()
    let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
    if branch != ''
      return "(" . substitute(branch, '\n', '', 'g') . ")"
    else
      return ''
    endif
endfunction

function! RvmOrFiletype()
  if &filetype=='ruby'
    let status = ''
    if !empty($rvm_path)
      let status = $rvm_ruby_string . "@" . $rvm_gemset_name
    endif
    return status
  else
    return strlen(&filetype)?&filetype:'none'
  endif
endfunction

" tab auto-complete
function! SuperTab()
  if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
    return "\<Tab>"
  else
    return "\<C-n>"
  endif
endfunction

imap <Tab> <C-R>=SuperTab()<CR>

" utf-8 everywere
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

set showcmd
set listchars=tab:▸\ ,eol:¬
set clipboard=unnamed                             " use system clipboard

" set timeoutlen=300   " mapping timeout
set notimeout
" set ttimeoutlen=50   " keycode timeout

set undofile
set backup                     " no backup
set nowritebackup              " no backup during edit session
set noswapfile
set undodir=~/.vim/.cache/undo
set backupdir=~/.vim/.cache/backup
set directory=~/.vim/.cache/swap

" https://bitbucket.org/sjl/dotfiles/src/b5e60ade957d/vim/.vimrc
set wildmenu
set wildmode=list:longest:full                    "priority for tab completion
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

cnoremap ## <C-R>=expand('%:h').'/'<cr>

" ,p paste on new line
nnoremap <Leader>p o<C-R>"<Esc>
" ,n to toggle line number
nnoremap <Leader>n :setlocal number!<CR>

" hardcore level 1
" up/down arrows move betweeen buffers
nnoremap <down> :bprev<CR>
nnoremap <up>   :bnext<CR>
" left/ right arrows between tabs
nnoremap <left> :tabprev<CR>
nnoremap <right> :tabnext<CR>

" tab movement
" map >> gt
" map << gT

" window movement ALT-l / ALT-h
nmap ¬ :wincmd l<CR>
nmap ˙ :wincmd h<CR>

" don't use linewise movement up/down -- http://statico.github.com/vim.html
" nmap j gj
" nmap k gk

" change position of cursor in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

set laststatus=2  " always show status line

"set so=7       " 7 lines when scrolling vertically
set ffs=unix   " eol
set showmatch  " show matching bracket
" set showbreak=↪\
" set mouse=a   " enable mouse
" set mousehide " hide when typing stuff
set ttyfast   " assume fast terminal connection

set noerrorbells
set novisualbell
set vb t_vb=     " no bells
set modeline     " show current mode
set incsearch    " do incremental search
set history=1000 " keep 50 lines in history
"set nowrap      " no wrap
set hlsearch     " highlight search word
set ruler
"set nu           " show line number
set nuw=2        " line numbers of 2 cols
set anti         " antialias on

set pastetoggle=<F6> " toggle paste with -e
set matchpairs+=<:>

set background=dark
colorscheme lucius
LuciusBlackLowContrast

if has("gui_running")
  " colors molokai
  " colors ir_black
  " colors mayansmoke
  set background=dark
  set cursorline
  set guifont=Inconsolata:h13
  " set guifont=Monaco:h11
  " set guifont=Comic\ Sans\ MS:h11
  set guioptions-=T  " no toolbar
  set guioptions-=r  " no right-hand scrollbar
  set guioptions-=L  " no left-hand scrollbar
  " set guioptions-=Rl " no other scrollbars
  set guioptions+=c  " console dialogs
  " full screen mode, cmd-cr toggles full screen
  set fuoptions=maxhorz,maxvert
  nmap <D-CR> :set invfu<CR>
  set statusline=[%{getcwd()}\%{GitBranch()}\]\ %f\ %2*%m\ %1*%h%r%=%{strlen(RvmOrFiletype())?RvmOrFiletype():'none'}\ 0x%B\ %12.(%c:%l/%L%)
endif

" Disable html5 stuff that I don't use
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

hi Todo guifg=#FF0000 guibg=#FF7F50
hi TODO guifg=#FF0000 guibg=#FF7F50
hi XXX  guifg=#FF0000 guibg=#FF7F50

autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufWritePre *.c :%s/\s\+$//e
au BufRead,BufNewFile *.scss  set filetype=scss
" au BufRead,BufNewFile *.scss  set filetype=eruby
au BufRead,BufNewFile Rakefile set filetype=ruby
au BufRead,BufNewFile Guardfile set filetype=ruby
au BufRead,BufNewFile Gemfile set filetype=ruby

au FileType c setlocal shiftwidth=4 softtabstop=4
au FileType cpp setlocal shiftwidth=4 softtabstop=4
" au Filetype sh,bash set ts=4 sts=4 sw=4 expandtab
" autocmd FileType javascript setlocal ai et sta sw=4 sts=4

" Save when losing focus
au FocusLost * :wa
" Save when leaving insert mode
autocmd InsertLeave * if &modified && expand('%') != '' | write | endif

" reload vimrc on the fly
" http://media.vimcasts.org/videos/24/vimrc_on_the_fly.m4v
" autocmd bufwritepost .vimrc source $MYVIMRC

" w!! when you forgot sudo
cmap w!! %!sudo tee > /dev/null %

let g:ackprg="ack -H --nocolor --nogroup --column --ruby"

" Highlight trailing whitespace
" http://stackoverflow.com/questions/356126/
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

au FileType c,cpp,java,php,javascript,ruby,html
  \ au BufWritePre * :call <SID>StripTrailingWhitespaces()

