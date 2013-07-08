set nocompatible
set t_Co=256

let mapleader=','

call pathogen#infect()

syntax on
filetype plugin indent on

" -- Formating
set autoindent    " always set autoindenting on
set expandtab     " spaces not tabs
set nosmarttab    " tabs at start of lines
set smartindent   " indents for you
set tabstop=2     " size of a tab
set shiftwidth=2  " size for auto/smartindent
set softtabstop=2 " a tab is this size

" -- Folding
set foldmethod=indent
set foldlevelstart=99
set foldnestmax=5
set foldclose=all

" -- UTF-8 ALL THE THINGS
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileformats=unix,dos,mac " EOL formats

" -- Commands
set ruler          " show the line and column number of the cursor position
set showcmd
set history=8000   " keep 50 lines in history

" -- Status line
set laststatus=2  " always show status line
set modeline      " show current mode

" -- Paste
set pastetoggle=<F6> " toggle paste with F6
set nopaste

" -- List
set listchars=tab:▸\ ,eol:¬
set nolist

" -- Scrolling
set so=5       " 5 lines when scrolling vertically
set siso=5     " 5 lines in side (left) scroll

" -- Title
set title
set titlestring=%f

" -- Backups / Undo / Swap files
set undofile
set backup                     " no backup
set nowritebackup              " no backup during edit session
set noswapfile
set undodir=~/.vim/.cache/undo
set backupdir=~/.vim/.cache/backup
set directory=~/.vim/.cache/swap

" -- Wildmenu (Tab completion)
"  inspiration: https://bitbucket.org/sjl/dotfiles/src/b5e60ade957d/vim/.vimrc
set wildmenu
set wildmode=list:longest:full                    "priority for tab completion
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX stuff
set wildignore+=tmp                              " Rails / Ruby stuff

" -- Search
set hlsearch     " highlight search word
set incsearch    " do incremental search

" -- Bells
set noerrorbells
set novisualbell
set vb t_vb=     " no bells

" -- Timeout mgmt
"set timeoutlen=20 " mapping timeout
"set ttimeoutlen=20
"set notimeout
"set nottimeout

" -- not sorted.
set cursorline                 " highlight the screen line of the cursor
set backspace=indent,eol,start " backspace over everything
set clipboard=unnamed          " use system clipboard
set showmatch                  " show matching bracket
set ttyfast                    " assume fast terminal connection
set nuw=2                      " line numbers of 2 cols
set matchpairs+=<:>

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

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" -- Mappings
cnoremap ## <C-R>=expand("%:h")."/"<cr>

" ,p paste on new line
nnoremap <Leader>p o<C-R>"<Esc>
" ,n to toggle line number
nnoremap <Leader>n :setlocal number!<CR>
" ,l to toggle list
nnoremap <Leader>l :setlocal list!<CR>
" ,g for git grep
nnoremap <Leader>g :GitGrep<space>
" ,, un-highlight search matches
nnoremap <Leader><Leader> :noh<CR>
" ,< vertical resize window to 3/2, ,. vertical resize window to 2/3
nnoremap <silent> <leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" text bubbling. http://vimcasts.org/episodes/bubbling-text/
"nmap <C-Up> ddkP
"nmap <C-Down> ddp

" Tab/shift-tab to indent/outdent in visual mode.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

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

" Move by screen lines instead of file lines -- http://statico.github.com/vim.html
nmap j gj
nmap k gk

" change position of cursor in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

" -- Color scheme / UI
set background=light
"set background=dark
colorscheme lucius
LuciusWhiteHighContrast

if has("gui_running")
  " colors molokai
  " colors ir_black
  " colors mayansmoke
  set background=dark
  set guifont=Inconsolata:h13
  " set guifont=Monaco:h11
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

" closetag plugin
let b:closetag_html_style=1

" ack plugin command
let g:ackprg="ag --nogroup --nocolor --column"

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
" cmap w!! %!sudo tee > /dev/null %

"let g:ackprg="ack -H --nocolor --nogroup --column --ruby"

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

