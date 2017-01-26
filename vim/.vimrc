" -----------------------------------------------------------------------------
" vimrc
" Description: Config file for vim
" -----------------------------------------------------------------------------
" Location: $HOME/.vimrc
" -----------------------------------------------------------------------------

" Environment {{{
" -----------------------------------------------------------------------------
" vimconf is not vi-compatible
if &compatible
    set nocompatible
endif

" setup vimrc autogroup
augroup vimrc
  autocmd!
augroup END

" if encoding is not utf-8 set termencoding
if &encoding !=? 'utf-8'
    let &termencoding = &encoding
endif
" Set utf8 as standard encoding
set encoding=utf-8
set fileencoding=utf-8

" Use unix as the standard file type
set fileformats=unix,mac,dos

" files to search
set path=.,**
" Set to auto read when a file is changed from the outside
set autoread
" Automatically switch to file directory of buffer
autocmd vimrc BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" Cache files {{{
let cachedir = expand("~/.vim/cache")
if !isdirectory(cachedir)
    call mkdir(cachedir)
endif

" 10 marks, 100 searches, 1000 commands, 10 lines / register, 10 inputs,
"   10kb max size of item, disable hlsearch on start, viminfo file name
set viminfo='10,/100,:1000,<10,@10,s10,h,n~/.vim/cache/.viminfo

" spellfile
set spellfile=~/.vim/cache/en.utf-8.add

" create backupdir incase backup is set
let backupdir = expand("~/.vim/cache/backup")
if !isdirectory(backupdir)
    call mkdir(backupdir)
endif
set backupdir=~/.vim/cache/backup

" enable undofile in ~/.vim/cache/undo
if has('persistent_undo')
    let undodir = expand("~/.vim/cache/undo")
    if !isdirectory(undodir)
        call mkdir(undodir)
    endif
    set undodir=~/.vim/cache/undo
    set undofile
endif
" }}}

" disable spelling by default
set nospell
" disable backups by default
set nobackup
" Number of command lines to remember
set history=1000
" number of undos to keep
set undolevels=1000
" -----------------------------------------------------------------------------
" }}}

" Plugins {{{
" -----------------------------------------------------------------------------
" vim-plug plugin manager
call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'morhetz/gruvbox'

" buffers in tabline
Plug 'ap/vim-buftabline'

" split width fixer
Plug 'roman/golden-ratio'

" completion engine
Plug 'ajh17/VimCompletesMe'

" align everything
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" check syntax
Plug 'scrooloose/syntastic'

" text objects
Plug 'wellle/targets.vim'

" searching
Plug 'haya14busa/incsearch.vim'
Plug 'unblevable/quick-scope'

" racket language support
Plug 'wlangstroth/vim-racket', { 'for': ['racket'] }

" Automatically executes filetype plugin indent on and syntax enable
call plug#end()

" Enable filetype plugins
filetype plugin indent on
" -----------------------------------------------------------------------------
" }}}

" Interface {{{
" -----------------------------------------------------------------------------
" window title
set title

" disable mouse
set mouse=
" disable beep and flashing
set vb t_vb=

" Don't redraw while executing macros
set lazyredraw
" Faster redraws
set ttyfast

" A buffer becomes hidden when it is abandoned
set hidden

"splits go below w/focus
set splitbelow
" vsplits go right w/focus
set splitright

" always show statusline if able
if has('statusline')
    set laststatus=2
    " statusline formatting {{{
    " buffer number
    set statusline+=%4n

    " File name
    set statusline+=\ %<%F

    " read only flag
    set statusline+=%{&ro?'\ [≠]':''}

    " modified flag
    set statusline+=%{&mod?'\ [+]':''}

    " display a warning if fileformat isnt unix
    set statusline+=%{&ff!='unix'?'[ff:\ '.&ff.']':''}

    " display a warning if file encoding isnt utf-8
    set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'[ft:\ '.&fenc.']':''}

    " separate left/right side
    set statusline+=%=

    " syntax checking
    set statusline+=%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}

    " Cursor info
    set statusline+=\ %c:%l
    set statusline+=\ %P\ 
    " }}}
endif

" show cmds being typed if able
if has('cmdline_info')
    set showcmd
endif
" disable startup message
set shortmess+=I
" don't give ins-completion-menu messages
set shortmess+=c
" display the current mode
set showmode
" ---more--- like less
set more

" hilight cursor line
set cursorline
" fix scrolling
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
" keep cursor column pos
set nostartofline

" line numbers are good
set number
set ruler
" 99999 lines
set numberwidth=5

" Configure backspace so it acts as it should act
set backspace=indent,eol,start

" better auto complete
set wildmenu
" bash-like auto complete
set wildmode=longest,list,full
" dont display these kinds of files in wildmenu {{{
set wildignore=*~
" vim temp files
set wildignore+=*.swp,*.swo
" git
set wildignore+=*.git
" Unix
set wildignore+=*/tmp/*,*.so,*DS_Store*,*.dmg
" Windows
set wildignore+=*\\tmp\\*,*.exe
" c
set wildignore+=*.a,*.o,*.so,*.obj
" python
set wildignore+=*.pyc
" ruby
set wildignore+=*.gem
" docs
set wildignore+=*.pdf
" archives
set wildignore+=*.zip
" pictures
set wildignore+=*.png,*.jpg,*.jpeg,*.gif
" directories
set wildignore+=*vim/cache*
set wildignore+=*sass-cache*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=log/**
set wildignore+=tmp/**
" }}}
" scan current and included files for defined name or macro
set complete+=d

" Makes search act like modern browsers
set incsearch
" Enables highlighting of search results
set hlsearch
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2
" matching for ci< or ci>
set matchpairs+=<:>

" Highlight problematic whitespace
set list listchars=tab:>\ ,trail:_,extends:>,precedes:<,nbsp:~
set showbreak=\\

" folds using syntax
set foldmethod=manual
" folds closed by default
set foldlevelstart=1
" hide folding column
set foldcolumn=0
" max 10 nested folds
set foldnestmax=10
" -----------------------------------------------------------------------------
" }}}

" Colors {{{
" -----------------------------------------------------------------------------
" Enable syntax highlighting
syntax on

" we're using a dark bg
set background=dark

" use this colorscheme
colorscheme gruvbox

" Visual like 'romainl/apprentice'
highlight Visual ctermbg=black ctermfg=blue cterm=reverse
highlight VisualNOS ctermbg=black ctermfg=white cterm=reverse
" MatchParen like 'romainl/apprentice'
highlight MatchParen ctermbg=black ctermfg=yellow cterm=NONE

" highlight trailing whitespace
highlight SpecialKey ctermbg=NONE ctermfg=DarkRed cterm=NONE
" -----------------------------------------------------------------------------
" }}}

" Formatting {{{
" -----------------------------------------------------------------------------
" spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab

" indent stuff
set autoindent
set smartindent
set shiftround

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set nojoinspaces

" not word dividers
set iskeyword+=_,$,@,%,#

" dont wrap lines
set nowrap
" dont cut words on wrap
set linebreak
" autowrap with newline char
set formatoptions+=t
" delete comment when joining commented lines
set formatoptions+=j

" filetype settings
autocmd vimrc BufNewFile,BufRead *.txt                         setl   ft=sh       tw=72
autocmd vimrc BufNewFile,BufRead *.md                          setl   ft=markdown tw=72
autocmd vimrc BufNewFile,BufRead *.conf                        setl   ft=cfg      tw=79
autocmd vimrc BufNewFile,BufRead *.tex                         setl   ft=tex      tw=79
autocmd vimrc BufNewFile,BufRead *.py                          setl   et ai       tw=79 ts=4 sts=4 sw=4
autocmd vimrc Filetype           gitcommit                     setl   spell       tw=72
autocmd vimrc Syntax             c,cpp,vim,xml,html,xhtml      setl   foldmethod=syntax
autocmd vimrc Syntax             c,cpp,vim,xml,html,xhtml,perl normal zR
" -----------------------------------------------------------------------------
" }}}

" Mappings {{{
" -----------------------------------------------------------------------------
" Conflicts when using mapleader so map space to \
map <space> <leader>

" Treat wrapped lines as normal lines
nnoremap j gj
nnoremap k gk

" toggle folds with enter
nnoremap <Enter> za

" Buffers
nnoremap <leader>b :ls<cr>:b<space>
nnoremap <leader>[ :bprevious<cr>
nnoremap <leader>] :bnext<cr>
" jump to alternate buffer
nnoremap <leader><space> <C-^>

" open horizontal / vertical window
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v
" open file under cursor in vertal split
nnoremap <leader>f :vertical wincmd f<CR>
" close windows
nnoremap <leader>c <C-W>c
nnoremap <leader>q <C-W>q
nnoremap <leader>o :only<CR>
" Move between windows
nnoremap <leader>h <C-W>h
xnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
xnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
xnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
xnoremap <leader>l <C-W>l
" resize windows
nnoremap <leader>H <C-W><
xnoremap <leader>H <C-W><
nnoremap <leader>J <C-W>-
xnoremap <leader>J <C-W>-
nnoremap <leader>K <C-W>+
xnoremap <leader>K <C-W>+
nnoremap <leader>L <C-W>>
xnoremap <leader>L <C-W>>
nnoremap <leader>- <C-W>\|
xnoremap <leader>- <C-W>\|
nnoremap <leader>\| <C-W>_
xnoremap <leader>\| <C-W>_

" Edit
noremap <leader>e :e<space>
noremap <leader>es :sp<space>
noremap <leader>ev :vsp<space>

" better search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" Quicker search / replace
nnoremap <leader>* *``cgn
nnoremap <leader># #``cgN
nnoremap <leader>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Change Y to be consistent with C and D
nnoremap Y y$

" yank/paste/delete to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy
nnoremap <leader>Y "+y$
nnoremap <leader>d "+d
nnoremap <leader>dd "+dd
nnoremap <leader>D "+D
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" select last changed block
nnoremap <leader>V `[v`]
" Go to the starting position after visual modes
vnoremap <ESC> o<ESC>
" don't exit visual mode while shifting
vnoremap < <gv
vnoremap > >gv

" check syntax
nmap <leader>ec :SyntasticCheck<CR>

" reformat entire file
nnoremap <leader>= gg=G``
" Remove trailing whitespace
nnoremap <leader>w m`:%s/\s\+$//<CR>:let @/=''<CR>``
" alignment
nmap <leader>a <Plug>(EasyAlign)
xmap <leader>a <Plug>(EasyAlign)

" lets enter select items in popupmenu without newline
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" make single quote act like backtick
nnoremap ' `

" disable ex mode
nnoremap Q <Nop>
" disable keyword man page
nnoremap K <Nop>
" -----------------------------------------------------------------------------
" }}}

" Plugin Settings {{{
" -----------------------------------------------------------------------------
" buftabline {{{
let g:buftabline_show = 1
let g:buftabline_numbers = 1
let g:buftabline_indicators = 1
" }}}

" incsearch.vim {{{
" auto diable hlsearch on non search movement
let g:incsearch#auto_nohlsearch = 1
" }}}

" syntastic {{{
" Settings
let g:syntastic_auto_loc_list = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_highlighting = 0

" Formatting
let g:syntastic_loc_list_height = 8
let g:syntastic_stl_format = "[%E{Err: %e, line %fe}%B{ / }%W{Warn: %w, line %fw}]"

" Syntax mode by filetype
let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': ['c', 'javascript', 'coffee', 'cpp', 'rust', 'ruby']}

" file type settings
let g:syntastic_c_check_header          = 0
let g:syntastic_c_compiler_options      = ' -Wextra -Wall'
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_cpp_compiler_options    = ' -Wextra -Wall -std=c++11'
" }}}

" netrw {{{
let g:netrw_banner = 0
let g:netrw_list_hide = '^\.$'
let g:netrw_liststyle = 3
" }}}
" -----------------------------------------------------------------------------
" }}}

" vim:foldmethod=marker:foldlevel=0
