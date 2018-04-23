" -----------------------------------------------------------------------------
" Description: Config file for nvim
" Location: $XDG_CONFIG_HOME/nvim/init.vim
" -----------------------------------------------------------------------------

" Environment {{{
" -----------------------------------------------------------------------------
" enable undofile
if has('persistent_undo')
    set undofile
endif

" Automatically switch to file directory of buffer
set autochdir
" -----------------------------------------------------------------------------
" }}}

" Plugins {{{
" -----------------------------------------------------------------------------
"  TODO: Disable netrw
" vim-plug plugin manager (takes plugin directory as argument)
call plug#begin('~/.local/share/nvim/plugged')

" buffers in tabline
Plug 'ap/vim-buftabline'

" split width fixer
Plug 'roman/golden-ratio'

" completion engine
Plug 'ajh17/VimCompletesMe'

" align everything
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" check syntax
Plug 'w0rp/ale'

" text objects
Plug 'wellle/targets.vim'

" searching
Plug 'haya14busa/is.vim'

" update &runtimepath and initialize plugins
"   Automatically executes filetype plugin indent on and syntax enable
call plug#end()

" ale {{{
" messaging
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%: %linter%] %s'
" }}}

" buftabline {{{
let g:buftabline_show = 1
let g:buftabline_numbers = 1
" let g:buftabline_indicators = 0
" }}}
" -----------------------------------------------------------------------------
" }}}

" Interface {{{
" -----------------------------------------------------------------------------
" Don't redraw while executing macros
set lazyredraw

" Buffers and Splits {{{
" A buffer becomes hidden when it is abandoned
set hidden

" splits go below w/focus
set splitbelow
" vsplits go right w/focus
set splitright
" }}}

" Statusline {{{
if has('statusline')
    " File Flags
    function! FileFlags() abort
        let l:flags=''

        if &readonly
            let l:flags.=' [≠]'
        endif

        if &modified
            let l:flags.=' [+]'
        endif

        if &fileformat !=? 'unix'
            let l:flags.=' [ff: &fileformat]'
        endif

        if &fileencoding !=? 'utf-8'
            let l:flags.=' [fe: &fileencoding]'
        endif

        return l:flags
    endfunction

    " Linter Status
    function! LinterStatus() abort
        " count linter info
        let l:counts = ale#statusline#Count(bufnr(''))
        " if no info return
        if l:counts.total == 0
            return ''
        endif

        " sort linter info
        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors

        " format linter info
        let l:linter=''
        " Add linter errors
        if l:all_errors >= 1
            let l:linter.=printf('%d error(s) ', l:all_errors)
        endif
        " Add linter warnings
        if l:all_non_errors >= 1
            let l:linter.=printf('%d warning(s) ', l:all_non_errors)
        endif

        return l:linter
    endfunction

    function! StatusLine() abort
        " Buffer number
        let l:status=' %n'

        " File name
        let l:status.=' %<%F'

        " Flags
        let l:status.='%{FileFlags()}'

        " separate left/right side
        let l:status.='%='

        " Linter status
        let l:status.='%{LinterStatus()}'

        " Cursor info
        if &number
            let l:status.='%l:%c '
        else
            let l:status.='%l(%L):%c '
        endif

        return l:status
    endfunction

    " always show statusline if able
    set statusline=%!StatusLine()
endif
" }}}

" Messages {{{
" disable startup message
set shortmess+=I

" don't give ins-completion-menu messages
set shortmess+=c
" }}}

" Search {{{
" Enables highlighting of search results
set hlsearch

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" For regular expressions turn magic on
set magic
" }}}

" Folds {{{
" fold using syntax
set foldmethod=manual

" hide folding column
set foldcolumn=0

" max 10 nested folds
set foldnestmax=4
" }}}

" Cursor {{{
" don't highlight cursor line
set nocursorline

" keep cursor column pos
set nostartofline

" line numbers
set number

" fix scrolling
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2
" matching for ci< or ci>
set matchpairs+=<:>
" }}}

" Syntax {{{
" Enable syntax highlighting
syntax on

" use this colorscheme
colorscheme krul

" Highlight problematic whitespace
set list listchars=tab:>\ ,trail:_,extends:>,precedes:<,nbsp:~
set showbreak=\\

augroup syntax_trail
    autocmd!
    autocmd InsertEnter * :set listchars-=trail:_
    autocmd InsertLeave * :set listchars+=trail:_
augroup END
" }}}
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
set shiftround

" 1 tab == 8 spaces
set tabstop=8
set softtabstop=4
set shiftwidth=4
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

" Sentences delimit by two spaces
set cpoptions+=J

" git {{{
augroup ft_git
    autocmd!
    autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
    autocmd Filetype git,gitcommit setlocal spell tw=72
augroup END
" }}}

" C {{{
augroup ft_c
    autocmd!
    autocmd FileType c,cpp setlocal foldmethod=marker foldmarker={,}
    autocmd FileType c,cpp setlocal nospell tw=79 ts=8 sts=8 sw=8 expandtab
augroup END
" }}}

" Python {{{
augroup ft_python
    autocmd!
    autocmd FileType python setlocal foldmethod=syntax foldlevel=1
    autocmd FileType python setlocal nospell tw=79 ts=8 sts=4 sw=4 expandtab
augroup END
" }}}

" Text {{{
augroup ft_text
    autocmd!
    autocmd FileType markdown,text,txt setlocal spell tw=72 ts=4 sts=4 sw=4 noexpandtab
augroup END
" }}}
" -----------------------------------------------------------------------------
" }}}

" Mappings {{{
" -----------------------------------------------------------------------------
" fix escape key delay
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" disable mouse
set mouse=

" Conflicts when using mapleader so map space to \
map <space> <leader>

" Treat wrapped lines as normal lines
nnoremap j gj
nnoremap k gk

" toggle folds with enter
nnoremap <Enter> za

" jump to alternate buffer
nnoremap <leader><space> <C-^>
" Buffers
nnoremap <leader>b :ls<cr>:b<space>
nnoremap <leader>[ :bprevious<cr>
nnoremap <leader>] :bnext<cr>
" buffer delete
nnoremap <leader><BS> :bd<cr>

" open horizontal / vertical window
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v
" close windows
nnoremap <leader>c <C-W>c
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
noremap <leader>es :sp<space>
noremap <leader>ev :vsp<space>
" Open file under cursor in vertal split
nnoremap <leader>f :vertical wincmd f<CR>

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

" Go to the starting position after visual modes
vnoremap <ESC> o<ESC>
" don't exit visual mode while shifting
vnoremap < <gv
vnoremap > >gv

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

" vim:foldmethod=marker:foldlevel=0
