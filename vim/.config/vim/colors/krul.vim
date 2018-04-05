" 'krul.vim' -- Vim color scheme.
" Author:      Taylor Wilton (git.twilton@gmail.com)
" Description: Color scheme using only color{0-15} modified from 'apprentice' by
"              Romain Lafourcade (romainlafourcade@gmail.com)

" Setup {{{
" -----------------------------------------------------------------------------
" Clear existing colorscheme
hi clear

if exists("syntax_on")
  syntax reset
endif

" Name
let colors_name = "krul"

" Use 4 bit colorscheme
set t_Co=16
" Light background colorscheme
set background=light
" -----------------------------------------------------------------------------
" }}}

" Definitions {{{
" -----------------------------------------------------------------------------
hi Normal        ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi Conceal       ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi Comment       ctermbg=NONE   ctermfg=darkgray cterm=NONE

hi Constant      ctermbg=NONE   ctermfg=cyan     cterm=NONE
hi String        ctermbg=NONE   ctermfg=green    cterm=NONE
hi Number        ctermbg=NONE   ctermfg=blue     cterm=NONE

hi Identifier    ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi Statement     ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi PreProc       ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi Type          ctermbg=NONE   ctermfg=magenta  cterm=NONE
hi Special       ctermbg=NONE   ctermfg=NONE     cterm=NONE

hi Underlined    ctermbg=NONE   ctermfg=NONE     cterm=underline
hi Ignore        ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi Error         ctermbg=NONE   ctermfg=red      cterm=reverse
hi Todo          ctermbg=gray   ctermfg=NONE     cterm=NONE

hi LineNr        ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi NonText       ctermbg=NONE   ctermfg=NONE     cterm=NONE

hi Pmenu         ctermbg=gray   ctermfg=NONE     cterm=NONE
hi PmenuSbar     ctermbg=gray   ctermfg=NONE     cterm=NONE
hi PmenuSel      ctermbg=yellow ctermfg=NONE     cterm=NONE
hi PmenuThumb    ctermbg=yellow ctermfg=NONE     cterm=NONE

hi ModeMsg       ctermbg=gray   ctermfg=NONE     cterm=NONE
hi ErrorMsg      ctermbg=red    ctermfg=NONE     cterm=NONE
hi WarningMsg    ctermbg=yellow ctermfg=NONE     cterm=NONE
hi MoreMsg       ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi Question      ctermbg=NONE   ctermfg=NONE     cterm=NONE

hi TabLine       ctermbg=gray   ctermfg=NONE     cterm=NONE
hi TabLineFill   ctermbg=gray   ctermfg=NONE     cterm=NONE
hi TabLineSel    ctermbg=yellow ctermfg=NONE     cterm=NONE

hi Cursor        ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi CursorColumn  ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi CursorLineNr  ctermbg=gray   ctermfg=NONE     cterm=NONE
hi CursorLine    ctermbg=gray   ctermfg=NONE     cterm=NONE

hi helpLeadBlank ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi helpNormal    ctermbg=NONE   ctermfg=NONE     cterm=NONE

hi StatusLine    ctermbg=gray   ctermfg=NONE     cterm=NONE
hi StatusLineNC  ctermbg=gray   ctermfg=darkgray cterm=NONE

hi Visual        ctermbg=NONE   ctermfg=blue     cterm=reverse
hi VisualNOS     ctermbg=NONE   ctermfg=blue     cterm=reverse

hi FoldColumn    ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi Folded        ctermbg=NONE   ctermfg=NONE     cterm=NONE

hi VertSplit     ctermbg=gray   ctermfg=gray     cterm=NONE
hi WildMenu      ctermbg=blue   ctermfg=NONE     cterm=NONE

hi SpecialKey    ctermbg=NONE   ctermfg=gray     cterm=NONE
hi Title         ctermbg=NONE   ctermfg=NONE     cterm=NONE

hi DiffAdd       ctermbg=NONE   ctermfg=green    cterm=reverse
hi DiffChange    ctermbg=NONE   ctermfg=magenta  cterm=reverse
hi DiffDelete    ctermbg=NONE   ctermfg=red      cterm=reverse
hi DiffText      ctermbg=NONE   ctermfg=red      cterm=reverse

hi IncSearch     ctermbg=blue ctermfg=yellow      cterm=NONE
hi Search        ctermbg=yellow ctermfg=NONE     cterm=NONE

hi Directory     ctermbg=NONE   ctermfg=cyan     cterm=NONE
hi MatchParen    ctermbg=gray   ctermfg=NONE     cterm=NONE

hi SpellBad      ctermbg=NONE   ctermfg=red      cterm=undercurl
hi SpellCap      ctermbg=NONE   ctermfg=NONE     cterm=undercurl
hi SpellLocal    ctermbg=NONE   ctermfg=NONE     cterm=undercurl
hi SpellRare     ctermbg=NONE   ctermfg=NONE     cterm=undercurl

hi ColorColumn   ctermbg=NONE   ctermfg=NONE     cterm=NONE
hi SignColumn    ctermbg=NONE   ctermfg=NONE     cterm=NONE

hi link Character      String
hi link Boolean        Constant
hi link Float          Number

hi link Function       Identifier

hi link Conditional    Statement
hi link Repeat         Statement
hi link Label          Statement
hi link Operator       Statement
hi link Keyword        Statement
hi link Exception      Statement
hi link HelpCommand    Statement
hi link HelpExample    Statement

hi link Include        PreProc
hi link Define         PreProc
hi link Macro          PreProc
hi link PreCondit      PreProc

hi link StorageClass   Type
hi link Structure      Type
hi link Typedef        Type

hi link SpecialChar    Special
hi link Tag            Special
hi link Delimiter      Special
hi link SpecialComment Special
hi link Debug          Special
" -----------------------------------------------------------------------------
" }}}

" Plugins {{{
" -----------------------------------------------------------------------------
" BufTabLine {{{
hi BufTabLineActive ctermbg=yellow ctermfg=darkgray cterm=NONE
" }}}
" -----------------------------------------------------------------------------
" }}}

" vim:foldmethod=marker:foldlevel=0
