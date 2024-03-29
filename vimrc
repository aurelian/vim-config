set nocompatible
" set t_Co=256

let mapleader="\<Space>"

let g:ale_completion_enabled=0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0

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
set wildmode=longest:list,full
" set wildmode=list:longest:full                    "priority for tab completion

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

function! QFVert()
let qf_buffer_ln = line('.')
wincmd p
vnew
execute "cc ".qf_buffer_ln
endfunction

nnoremap <Leader>v :call QFVert()<CR>
nnoremap <Leader>n :cn<CR>
nnoremap <leader>c :ccl<CR>

nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>
nnoremap <leader>s byw:Ack! <C-r>"
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

"function! SuperGoTab()
"if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
"  return "\<Tab>"
"else
"  return "\<C-x><C-o>"
"endif
"endfunction
"autocmd FileType go imap <buffer> <Tab> <C-R>=SuperGoTab()<CR>

au filetype go inoremap <buffer> .<leader> .<C-x><C-o>

function! Vicious()
let match = search('.if$', 'bn', line('w0'))

if match > 0
  return "\<ESC>2hd$^iif \<ESC>o"
endif
" return "\<ESC>2hd$^iif \<ESC>$i\<C-O>o"
endfunction

imap xx <C-R>=Vicious()<CR>
imap bp binding.pry

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" -- Mappings
cnoremap ## <C-R>=expand("%:h")."/"<cr>

" F9 to Dispatch.
nnoremap <F9> :Dispatch<CR>
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
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l
nmap <c-h> <c-w>h

" Move by screen lines instead of file lines -- http://statico.github.com/vim.html
nmap j gj
nmap k gk

" change position of cursor in insert mode
inoremap <c-h> <left>
inoremap <c-l> <right>

" save with jj
inoremap jj <Esc>:w<CR>
" nmap jj <Esc><CR>

autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

" rspec
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec --format=doc {spec}\n")'
autocmd BufNewFile,BufRead *_spec.rb set filetype=rspec.ruby
autocmd FileType rspec.ruby nnoremap <buffer> <Leader>t :call RunCurrentSpecFile()<CR>
autocmd FileType rspec.ruby,ruby nnoremap <buffer> <Leader>r :call RunLastSpec()<CR>
autocmd FileType rspec.ruby,ruby nnoremap <buffer> <Leader>l :call RunAllSpecs()<CR>

"autocmd FileType rust nnoremap <buffer> <Leader>t :call RunCurrentSpecFile()<CR>
"autocmd FileType rspec.ruby,ruby nnoremap <buffer> <Leader>o :call Send_to_Tmux("rubocop -a " . @% . "\n")<CR>
"autocmd FileType rspec.ruby nnoremap <buffer> <Leader>o :call Send_to_Tmux("rubocop -a " . @% . "\n")<CR>

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" ALE -- https://github.com/w0rp/ale
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'ruby': ['rubocop', 'rufo'],
      \ 'rspec.ruby': ['rubocop', 'rufo'],
      \ }

let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'

" golang stuff
" let g:go_auto_sameids = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
" let g:go_fmt_experimental = 1
" let g:go_metalinter_autosave=1
" let g:go_metalinter_autosave_enabled=['golint', 'govet']

autocmd FileType rspec.ruby,ruby nnoremap <buffer> <Leader>i :ALELint<CR>
autocmd FileType rspec.ruby,ruby nnoremap <buffer> <Leader>o :ALEFix<CR>:w<CR>:e<CR>

au BufRead,BufNewFile *.md.gpg setfiletype gpgmd
" MDGPG
function! <SID>StartEditingGPG()
  echom "--> file is: " . expand("%")
  colorscheme base16-green-screen
endfunction

augroup MarkdownGnuPG
  autocmd!

  autocmd FileType gpgmd
    \ autocmd BufReadPre * :call <SID>StartEditingGPG()
augroup END
" end MDGPG

let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

let g:clj_fmt_autosave = 0
let g:terraform_fmt_on_save=1

" cursor mode change -- https://github.com/mhinz/vim-galore/blob/master/README.md#change-cursor-style-dependent-on-mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"

" -- Color scheme / UI

"if (has("termguicolors"))
"  set termguicolors
"endif

let base16colorspace=256

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
  set nu
endif

" colorscheme codedark
colorscheme zellner

set background=light

" Disable html5 stuff that I don't use
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" closetag plugin
let b:closetag_html_style=1

" ack plugin command
let g:ackprg="ag --vimgrep --nogroup --nocolor --column"
let g:ack_use_dispatch = 1

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

" Dispatch
autocmd BufRead,BufNewFile **/spec/*_spec.rb let b:dispatch = 'bundle exec rspec %'
autocmd BufRead,BufNewFile Gemfile let b:dispatch = 'bundle install'
autocmd BufRead,BufNewFile *.gemspec let b:dispatch = 'bundle install'

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

autocmd FileType c,cpp,java,php,javascript,ruby,html,haml
  \ autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

autocmd VimEnter * RainbowParenthesesActivate
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

nmap <Leader>f :Files<CR>
nmap <Leader>b :Buffers<CR>

map <Leader>rt :!/usr/local/Cellar/ctags/5.8_1/bin/ctags --language-force=ruby --exclude=.git --exclude=log -R * `bundle show --paths`<CR>

autocmd FileType rspec.ruby iabbrev <buffer> l let(: ) { create(: ) }
autocmd FileType rspec.ruby iabbrev <buffer> it it 'does stuff' do

" wrap the current line in (), e.g:
nnoremap (( mMI(<esc>A)<esc>`M

" wrap the rest of the line in ()
nnoremap )) mMi(<esc>A)<esc>`M
" Rebinds J and K in visual mode to move block up or down in relation to the other lines, while keeping the selection.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
