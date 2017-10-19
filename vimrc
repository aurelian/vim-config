set nocompatible
set t_Co=256

let mapleader="\<Space>"

let g:clj_fmt_autosave = 0

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

" -- Splits
set splitbelow
set splitright

" -- Paste
set pastetoggle=<F2> " toggle paste
set nopaste

" -- List
set listchars=tab:▸\ ,eol:¬
"set list
"set nu
"set rnu

" -- Scrolling
set so=8       " 5 lines when scrolling vertically
set siso=6     " 5 lines in side (left) scroll

" -- Title
set title
set titlestring=%f

" -- Backups / Undo / Swap files
set undofile
set backup                     " no backup
"set nowritebackup              " no backup during edit session
set noswapfile
set undodir=~/.vim/.cache/undo/
set backupdir=~/.vim/.cache/backup/
set directory=~/.vim/.cache/swap/

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
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*
set wildignore+=*/tmp/*                          " Rails / Ruby stuff

" -- Search
set hlsearch     " highlight search word
set incsearch    " show match while typing
set showmatch
set ignorecase
set smartcase
" set gdefault " no need to /g to replace all

"https://github.com/toranb/dotfiles/blob/daf05812bed08b9c6d367aeb0b6ccd12764765dd/vimrc#L333-L340
function! VisualFindAndReplace()
    :OverCommandLine%s/
    :w
endfunction

function! VisualFindAndReplaceWithSelection() range
    :'<,'>OverCommandLine s/
    :w
endfunction

nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>
nnoremap <leader>s byw:Ack <C-r>"
nnoremap <leader>c :ccl<CR>
" nnoremap <silent> <buffer> c :ccl<CR>
" Sane regexes
nnoremap / /\v
vnoremap / /\v

" -- Bells
set noerrorbells
set novisualbell
set vb t_vb=     " no bells

" -- All about numbers
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber
"autocmd FocusLost * :set number
"autocmd FocusGained * :set relativenumber

" -- Timeout mgmt
"set timeoutlen=20 " mapping timeout
"set ttimeoutlen=20
"set notimeout
"set nottimeout

" -- not sorted.
set backspace=indent,eol,start " backspace over everything
set clipboard=unnamed          " use system clipboard
set ttyfast                    " assume fast terminal connection
set nuw=2                      " line numbers of 2 cols
set matchpairs+=<:>
" set iskeyword-=_               " include _ as a word boundary

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

" F9 to Dispatch.
nnoremap <F9> :Dispatch
" F8. gf in vertical split
nnoremap <F8> :vertical wincmd f<CR>

" select till end/beginning of line
vmap L $
vmap H ^

" ,p paste on new line
nnoremap <Leader>p o<C-R>"<Esc>
" ,n to toggle line number
"nnoremap <Leader>n :setlocal number!<CR>
" ,l to toggle list
" nnoremap <Leader>l :setlocal list!<CR>
nnoremap <Leader>e :normal ggg?VG<CR>
" ,g for git grep
" nnoremap <Leader>g :GitGrep<space>
" ,, un-highlight search matches
nnoremap <Leader><Leader> :noh<CR>
" ,< vertical resize window to 3/2, ,. vertical resize window to 2/3
nnoremap <silent> <leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
" http://vimcasts.org/e/56
nnoremap Q 0yt=A<C-r>=<C-r>"<CR><Esc>
" switch to light colorscheme
nnoremap <Leader>a :colorscheme lucius<CR>:LuciusLightLowContrast<CR>

" lol... actually I don't need SHIFT all the time
nnoremap ; :

" Don't move to next occurence when searching with *
nnoremap * *<C-O>
" Keep search to center of screen
nnoremap N Nzzzv
nnoremap n nzzzv
" Easy to type.
nnoremap H ^
nnoremap L $

" text bubbling. http://vimcasts.org/episodes/bubbling-text/
"nmap <C-Up> ddkP
"nmap <C-Down> ddp

" Tab/shift-tab to indent/outdent in visual mode.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv
vnoremap // y/<C-R>"<CR>
" Select previously pasted content with Leader-v
nnoremap <leader>v V`]

" hardcore level 1
" up/down arrows move betweeen buffers
nnoremap <down> :bprev<CR>
nnoremap <up>   :bnext<CR>
" fast buffer switch
nnoremap gb :ls<CR>:b<Space>
" left/ right arrows between tabs
nnoremap <left> :tabprev<CR>
nnoremap <right> :tabnext<CR>

" move between windows with ctrl + hjkl
" disabled because of vim-tmux-navigator
" nmap <c-j> <c-w>j
" nmap <c-k> <c-w>k
" nmap <c-l> <c-w>l
" nmap <c-h> <c-w>h

" Move by screen lines instead of file lines -- http://statico.github.com/vim.html
nmap j gj
nmap k gk

" change position of cursor in insert mode
inoremap <c-h> <left>
inoremap <c-l> <right>

" save with jj
inoremap jj <Esc>:w<CR>
" ii exits insert mode
" imap ii <Esc>
inoremap jk <Esc>
inoremap kj <Esc>

" cursor mode change -- https://github.com/mhinz/vim-galore/blob/master/README.md#change-cursor-style-dependent-on-mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"

" -- Color scheme / UI
set background=dark
let base16colorspace=256
colorscheme codedark

set cursorline                 " highlight the screen line of the cursor
highlight CursorLine ctermbg=None ctermfg=None cterm=bold
" highlight CursorLine ctermbg=8 ctermfg=None
autocmd InsertEnter * highlight CursorLine ctermbg=None ctermfg=None cterm=None
autocmd InsertLeave * highlight CursorLine ctermbg=None ctermfg=None cterm=bold

" highlight for tabs
hi TabLineSel  ctermfg=Red ctermbg=Yellow cterm=bold
hi TabLine     ctermfg=Darkblue ctermbg=Yellow
hi TabLineFill ctermfg=None ctermbg=None

" highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100) " warn me only when passing over 100 lines in a column

if has("gui_running")
  set guifont=Monaco:h11
  set guioptions-=T  " no toolbar
  set guioptions-=r  " no right-hand scrollbar
  set guioptions-=L  " no left-hand scrollbar
  " set guioptions-=Rl " no other scrollbars
  set guioptions+=c  " console dialogs
  " full screen mode, cmd-cr toggles full screen
  set fuoptions=maxhorz,maxvert
  nmap <D-CR> :set invfu<CR>
  colorscheme codedark
  set nu
endif

" Disable html5 stuff that I don't use
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" closetag plugin
let b:closetag_html_style=1

" ack plugin command
let g:ackprg="ag --vimgrep --nogroup --nocolor --column"

" jsx plugin: enable jsx in .js files
let g:jsx_ext_required = 0

set rtp+=/usr/local/opt/fzf

nmap ' :Files<CR>

hi Todo guifg=#FF0000 guibg=#FF7F50
hi TODO guifg=#FF0000 guibg=#FF7F50
hi XXX  guifg=#FF0000 guibg=#FF7F50

" autocmd BufWritePre *.rb :%s/\s\+$//e
" autocmd BufWritePre *.c :%s/\s\+$//e
" autocmd BufWritePre *.go :%s/\s\+$//e
autocmd BufRead,BufNewFile *.scss  set filetype=scss
autocmd BufRead,BufNewFile *.boot  set filetype=clojure
autocmd BufRead,BufNewFile Rakefile set filetype=ruby
autocmd BufRead,BufNewFile Guardfile set filetype=ruby
autocmd BufRead,BufNewFile Gemfile set filetype=ruby
autocmd BufRead,BufNewFile *.es6 set filetype=javascript
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType c setlocal shiftwidth=4 softtabstop=4
autocmd FileType cpp setlocal shiftwidth=4 softtabstop=4
autocmd FileType rust setlocal shiftwidth=4 softtabstop=4
" autocmd FileType javascript setlocal shiftwidth=4 softtabstop=4

autocmd BufRead,BufNewFile **/spec/*_spec.rb let b:dispatch = 'bundle exec rspec %'

" Save when losing focus
autocmd FocusLost * :wa
" Save when leaving insert mode
autocmd InsertLeave * if &modified && expand('%') != '' | write | endif

" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="
" autocmd BufNewFile * set noeol

" reload vimrc on the fly
" http://media.vimcasts.org/videos/24/vimrc_on_the_fly.m4v
" autocmd bufwritepost .vimrc source $MYVIMRC

" w!! when you forgot sudo
" cmap w!! %!sudo tee > /dev/null %

" Highlight trailing whitespace
" http://stackoverflow.com/questions/356126/
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace guibg=red
autocmd BufEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

" for .hql files
autocmd BufNewFile,BufRead *.hql set filetype=hive expandtab
"
" for .q files
autocmd BufNewFile,BufRead *.q set filetype=hive expandtab

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

autocmd FileType c,cpp,java,php,javascript,ruby,html
  \ autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

autocmd VimEnter * RainbowParenthesesActivate
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

