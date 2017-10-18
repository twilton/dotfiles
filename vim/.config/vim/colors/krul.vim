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
" -----------------------------------------------------------------------------
" }}}

" Definitions {{{
" -----------------------------------------------------------------------------
hi Normal        ctermbg=NONE   ctermfg=NONE    cterm=NONE

hi Comment       ctermbg=NONE   ctermfg=gray    cterm=NONE
hi Conceal       ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi Constant      ctermbg=NONE   ctermfg=red     cterm=NONE
hi Function      ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi Identifier    ctermbg=NONE   ctermfg=blue    cterm=NONE
hi PreProc       ctermbg=NONE   ctermfg=cyan    cterm=NONE
hi Special       ctermbg=NONE   ctermfg=green   cterm=NONE
hi Statement     ctermbg=NONE   ctermfg=blue    cterm=NONE
hi String        ctermbg=NONE   ctermfg=green   cterm=NONE
hi Todo          ctermbg=NONE   ctermfg=NONE    cterm=reverse
hi Type          ctermbg=NONE   ctermfg=magenta cterm=NONE

hi Error         ctermbg=NONE   ctermfg=red     cterm=reverse
hi Ignore        ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi Underlined    ctermbg=NONE   ctermfg=NONE    cterm=reverse

hi LineNr        ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi NonText       ctermbg=NONE   ctermfg=NONE    cterm=NONE

hi Pmenu         ctermbg=gray   ctermfg=NONE    cterm=NONE
hi PmenuSbar     ctermbg=gray   ctermfg=NONE    cterm=NONE
hi PmenuSel      ctermbg=NONE   ctermfg=blue    cterm=reverse
hi PmenuThumb    ctermbg=NONE   ctermfg=blue    cterm=reverse

hi ErrorMsg      ctermbg=red    ctermfg=NONE    cterm=NONE
hi ModeMsg       ctermbg=green  ctermfg=NONE    cterm=NONE
hi MoreMsg       ctermbg=NONE   ctermfg=cyan    cterm=NONE
hi Question      ctermbg=NONE   ctermfg=green   cterm=NONE
hi WarningMsg    ctermbg=NONE   ctermfg=red     cterm=NONE

hi TabLine       ctermbg=gray   ctermfg=NONE    cterm=NONE
hi TabLineFill   ctermbg=gray   ctermfg=NONE    cterm=NONE
hi TabLineSel    ctermbg=yellow ctermfg=NONE    cterm=NONE

hi Cursor        ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi CursorColumn  ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi CursorLineNr  ctermbg=gray   ctermfg=NONE    cterm=NONE
hi CursorLine    ctermbg=gray   ctermfg=NONE    cterm=NONE

hi helpLeadBlank ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi helpNormal    ctermbg=NONE   ctermfg=NONE    cterm=NONE

hi StatusLine    ctermbg=gray   ctermfg=NONE    cterm=NONE
hi StatusLineNC  ctermbg=darkgray   ctermfg=NONE    cterm=NONE

hi Visual        ctermbg=NONE   ctermfg=blue    cterm=reverse
hi VisualNOS     ctermbg=NONE   ctermfg=white   cterm=reverse

hi FoldColumn    ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi Folded        ctermbg=NONE   ctermfg=NONE    cterm=NONE

hi VertSplit     ctermbg=gray   ctermfg=gray    cterm=NONE
hi WildMenu      ctermbg=blue   ctermfg=NONE    cterm=NONE

hi SpecialKey    ctermbg=NONE   ctermfg=gray    cterm=NONE
hi Title         ctermbg=NONE   ctermfg=white   cterm=NONE

hi DiffAdd       ctermbg=NONE   ctermfg=green   cterm=reverse
hi DiffChange    ctermbg=NONE   ctermfg=magenta cterm=reverse
hi DiffDelete    ctermbg=NONE   ctermfg=red     cterm=reverse
hi DiffText      ctermbg=NONE   ctermfg=red     cterm=reverse

hi IncSearch     ctermbg=red    ctermfg=NONE    cterm=NONE
hi Search        ctermbg=yellow ctermfg=NONE    cterm=NONE

hi Directory     ctermbg=NONE   ctermfg=cyan    cterm=NONE
hi MatchParen    ctermbg=NONE   ctermfg=NONE    cterm=underline

hi SpellBad      ctermbg=NONE   ctermfg=red     cterm=undercurl
hi SpellCap      ctermbg=NONE   ctermfg=yellow  cterm=undercurl
hi SpellLocal    ctermbg=NONE   ctermfg=green   cterm=undercurl
hi SpellRare     ctermbg=NONE   ctermfg=magenta cterm=undercurl

hi ColorColumn   ctermbg=NONE   ctermfg=NONE    cterm=NONE
hi SignColumn    ctermbg=NONE   ctermfg=NONE    cterm=NONE

hi link Boolean                  Constant
hi link Character                Constant
hi link Conditional              Statement
hi link Debug                    Special
hi link Define                   PreProc
hi link Delimiter                Special
hi link Exception                Statement
hi link Float                    Number
hi link HelpCommand              Statement
hi link HelpExample              Statement
hi link Include                  PreProc
hi link Keyword                  Statement
hi link Label                    Statement
hi link Macro                    PreProc
hi link Number                   Constant
hi link Operator                 Statement
hi link PreCondit                PreProc
hi link Repeat                   Statement
hi link SpecialChar              Special
hi link SpecialComment           Special
hi link StorageClass             Type
hi link Structure                Type
hi link Tag                      Special
hi link Typedef                  Type

hi link htmlEndTag               htmlTagName
hi link htmlLink                 Function
hi link htmlSpecialTagName       htmlTagName
hi link htmlTag                  htmlTagName
hi link htmlBold                 Normal
hi link htmlItalic               Normal
hi link xmlTag                   Statement
hi link xmlTagName               Statement
hi link xmlEndTag                Statement

hi link markdownItalic           Preproc
hi link asciidocQuotedEmphasized Preproc

hi link diffBDiffer              WarningMsg
hi link diffCommon               WarningMsg
hi link diffDiffer               WarningMsg
hi link diffIdentical            WarningMsg
hi link diffIsA                  WarningMsg
hi link diffNoEOL                WarningMsg
hi link diffOnly                 WarningMsg
hi link diffRemoved              WarningMsg
hi link diffAdded                String
" -----------------------------------------------------------------------------
" }}}

" Plugins {{{
" -----------------------------------------------------------------------------
" BufTabLine {{{
hi BufTabLineActive ctermbg=cyan ctermfg=NONE    cterm=NONE
" }}}
" -----------------------------------------------------------------------------
" }}}

" vim:foldmethod=marker:foldlevel=0
