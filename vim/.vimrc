" -----------------------------------------------------------------------------
" vimrc
" Description: Config file for vim
" -----------------------------------------------------------------------------
" Location: $HOME/.vimrc
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" => Environment
" -----------------------------------------------------------------------------
" {{{
" vimconf is not vi-compatible
set nocompatible

" Set utf8 as standard encoding
set encoding=utf8

" Use unix as the standard file type
set ffs=unix,dos,mac
" }}}

" -----------------------------------------------------------------------------
" => Plugins
" -----------------------------------------------------------------------------
" {{{
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

" searching
Plug 'junegunn/vim-slash'

" racket language support
Plug 'wlangstroth/vim-racket', { 'for': ['racket'] }

" kick the habit
" Plug 'wikitopian/hardmode'
Plug 'takac/vim-hardtime'

call plug#end()
" }}}

" -----------------------------------------------------------------------------
" => General
" -----------------------------------------------------------------------------
" {{{
" dont use other .*rc(s)
set noexrc

" Sets how many lines of history VIM has to remember
set history=1000
" Persistent Undo
if has('persistent_undo')
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
    set undolevels=200
    set undoreload=5000
endif

" Enable filetype plugins
filetype plugin indent on
" }}}

" -----------------------------------------------------------------------------
" => Interface
" -----------------------------------------------------------------------------
" {{{
" window title
set title
" disable startup message
set shortmess+=I
" don't give ins-completion-menu messages
set shortmess+=c
" A buffer becomes hidden when it is abandoned
set hidden

" disable mouse
set mouse=
" disable beep and flashing
set vb t_vb=

" line numbers are good
set number
set ruler
" 99999 lines
set numberwidth=5
" hilight cursor line
set cursorline
" keep cursor column pos
set nostartofline


if has('cmdline_info')
    " show cmds being typed
    set showcmd
endif

if has('statusline')
    " always show statusline
    set laststatus=2
    " statusline formatting {{{
    " buffer number
    set statusline =%4*
    set statusline+=%4.4n
    set statusline+=%*

    " File name
    set statusline+=%1*
    set statusline+=\ %<%.99F\ 
    set statusline+=%*

    " help file flag
    set statusline+=%6*
    set statusline+=%h
    set statusline+=%*

    " modified flag
    set statusline+=%2*
    set statusline+=%m
    set statusline+=%*

    " read only flag
    set statusline+=%3*
    set statusline+=%{&ro?'[≠]':''}
    set statusline+=%*

    " display fugitive
    " set statusline+=%4*
    " set statusline+=[%{fugitive#head(6)}]
    " set statusline+=%*

    " display a warning if fileformat isnt unix
    set statusline+=%5*
    set statusline+=%{&ff!='unix'?'[ff:\ '.&ff.']':''}
    set statusline+=%*

    " display a warning if file encoding isnt utf-8
    set statusline+=%5*
    set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'[ft:\ '.&fenc.']':''}
    set statusline+=%*

    " separate left/right side
    set statusline+=%1*
    set statusline+=%=
    set statusline+=%*

    " syntax checking
    set statusline+=%5*
    set statusline+=%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}
    set statusline+=%*

    " Cursor info
    set statusline+=%1*
    set statusline+=\ %c:%l
    set statusline+=\ %P\ 
    set statusline+=%*
    " }}}
endif

" display the current mode
set showmode
" ---more--- like less
set more

" fix scrolling
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Configure backspace so it acts as it should act
set backspace=indent,eol,start
" Highlight problematic whitespace
set list listchars=tab:>\ ,trail:_,extends:>,precedes:<,nbsp:~
set showbreak=\\
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Enables highlighting of search results (this is modified by vim-slash)
set hlsearch
" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 
" Faster redraws
set ttyfast

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2
" matching for ci< or ci>
set matchpairs+=<:>

"splits go below w/focus
set splitbelow
" vsplits go right w/focus
set splitright

" folds using syntax
set foldmethod=manual
" folds closed by default
set foldlevelstart=1
" hide folding column
set foldcolumn=0
" max 10 nested folds
set foldnestmax=10

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
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=log/**
set wildignore+=tmp/**
" }}}
" scan current and included files for defined name or macro
set complete+=d
" }}}

" -----------------------------------------------------------------------------
" => Colors
" -----------------------------------------------------------------------------
" {{{
" Enable syntax highlighting
syntax on

" we're using a dark bg
set background=dark

" use this colorscheme
colorscheme gruvbox

" StatusLine colors
hi User1        ctermbg=239 ctermfg=white
hi User2        ctermbg=239 ctermfg=cyan
hi User3        ctermbg=239 ctermfg=yellow
hi User4        ctermbg=239 ctermfg=white
hi User5        ctermbg=239 ctermfg=red
hi User6        ctermbg=239 ctermfg=grey

" listchar colors
" hi NonText    ctermfg=red
hi SpecialKey ctermfg=red
" }}}

" -----------------------------------------------------------------------------
" => Files and directories
" -----------------------------------------------------------------------------
" {{{
" Set to auto read when a file is changed from the outside
set autoread
set nobackup
set nowb

" files to search
set path=.,**
" Automatically switch to file directory of buffer
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" formating for other filetypes
augroup FileTypeRules
    autocmd!
    autocmd BufNewFile,BufRead *.txt                         setl   ft=sh       tw=72
    autocmd BufNewFile,BufRead *.md                          setl   ft=markdown tw=72
    autocmd BufNewFile,BufRead *.conf                        setl   ft=cfg      tw=79
    autocmd BufNewFile,BufRead *.tex                         setl   ft=tex      tw=79
    autocmd BufNewFile,BufRead *.py                          setl   et ai       tw=79 ts=4 sts=4 sw=4
    autocmd Filetype           gitcommit                     setl   spell       tw=72
    autocmd Syntax             c,cpp,vim,xml,html,xhtml      setl   foldmethod=syntax
    autocmd Syntax             c,cpp,vim,xml,html,xhtml,perl normal zR
augroup END
" }}}

" -----------------------------------------------------------------------------
" => Formatting
" -----------------------------------------------------------------------------
" {{{
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
" }}}

" -----------------------------------------------------------------------------
" => Mappings
" -----------------------------------------------------------------------------
" {{{
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

" Edit
noremap <leader>ew :e<space>
noremap <leader>es :sp<space>
noremap <leader>ev :vsp<space>
noremap <leader>et :tabe<space>

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

" don't exit visual mode while shifting
vnoremap < <gv
vnoremap > >gv

" brace expansion on the cheap
inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [; [<CR>];<Esc>O
inoremap [, [<CR>],<Esc>O
" Working ci(, works for both breaklined, inline and multiple ()
nnoremap ci( %ci(

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

" make list-like commands more intuitive
" {{{
function! CCR()
    let cmdline = getcmdline()
    if cmdline =~ '\v\C^(ls|files|buffers)'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~ '\v\C^(dli|il)'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~ '\v\C^(cli|lli)'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~ '\C^old'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~ '\C^changes'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~ '\C^ju'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\C^marks'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~ '\C^undol'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<CR>"
    endif
endfunction
" }}}
cnoremap <expr> <CR> CCR()

" Quicker cgn/cgN
nnoremap <leader>* *``cgn
nnoremap <leader># #``cgN
nnoremap <leader>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

" make single quote act like backtick
nnoremap ' `

" hardmode :(
" nnoremap <leader>H <Esc>:call ToggleHardMode()<CR>
let g:hardtime_default_on = 1

" disable ex mode
nnoremap Q <nop>
" disable keyword man page
nnoremap K <nop>
" }}}

" -----------------------------------------------------------------------------
" => Plugin Settings
" -----------------------------------------------------------------------------
" {{{
    " -------------------------------------------------------------
    " => buftabline
    " -------------------------------------------------------------
    " {{{
    let g:buftabline_show = 1
    let g:buftabline_indicators = 1
    " }}}

    " -------------------------------------------------------------
    " => syntastic
    " -------------------------------------------------------------
    " {{{
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

    " -------------------------------------------------------------
    " => netrw - bundled file browser
    " -------------------------------------------------------------
    " {{{
    let g:netrw_banner = 0
    let g:netrw_list_hide = '^\.$'
    let g:netrw_liststyle = 3
    " }}}
" }}}

" vim:foldmethod=marker:foldlevel=0
