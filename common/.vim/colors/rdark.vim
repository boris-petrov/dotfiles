" Vim color file
" Maintaner: Radu Dineiu <radu.dineiu@gmail.com>
" URL: http://ld.yi.org/vim/rdark/
" Last Change: 2007 Jun 23
" Version: 0.6
"
" Features:
"   - let rdark_current_line = 1 if you want to highlight the current line
"
" Changelog:
"   0.5 - fixed the Pmenu colors
"   0.6 - added SignColumn colors

set background=dark

hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "rdark"

" Current Line
hi CursorLine guibg=#333333 guifg=NONE

" Default Colors
" hi Normal guifg=#babdb6 guibg=#1e2426
hi Normal guifg=#babdb6 guibg=Black
hi NonText guifg=#404040
hi Cursor guifg=Black guibg=Yellow
hi ICursor guibg=#babdb6
" highlight SpecialKey    guifg=#404040 ctermfg=8

" Search
hi Search guifg=Black guibg=Magenta
hi IncSearch guibg=Black guifg=Magenta

" Window Elements
hi StatusLine guifg=#2e3436 guibg=#babdb6 gui=none
hi StatusLineNC guifg=#2e3436 guibg=#888a85 gui=none
hi VertSplit guifg=#555753 guibg=#888a85 gui=none
hi Visual guibg=#555577
hi VisualNOS guibg=#444444
hi MoreMsg guifg=#729fcf
hi Question guifg=#8ae234 gui=none
hi WildMenu guifg=#eeeeec guibg=#0e1416
hi LineNr guifg=#DDEEFF guibg=#222222
hi SignColumn guibg=#1e2426

" Pmenu
hi Pmenu guifg=White guibg=#000099 gui=bold
hi PmenuSel guifg=White guibg=#5555ff gui=bold
hi PmenuSbar guibg=Grey ctermbg=Grey
hi PmenuThumb guibg=White ctermbg=White

" Folds
hi Folded guifg=#d3d7cf guibg=#204a87
hi FoldColumn guifg=#3465a4 guibg=#000000

" Specials
hi Title guifg=#fcaf3e
hi Todo guifg=Yellow guibg=bg
hi SpecialKey guifg=#ef2929

" Tabs
hi TabLine guibg=#0a1012 guifg=#888a85
hi TabLineFill guifg=#0a1012
hi TabLineSel guibg=#555753 guifg=#eeeeec gui=none

" Matches
hi MatchParen guifg=#2e3436 guibg=LightBlue

" Tree
hi Directory none
hi link Directory Identifier

hi User1 guifg=Blue guibg=#babdb6 gui=none
hi User2 guifg=Red guibg=#babdb6 gui=none

" Syntax
hi Comment guifg=#9933CC gui=italic
" TODO: the constant's color is very much the same as the normal text's
hi Constant guifg=#339999
" hi Number guifg=#8ae234
hi Statement guifg=#729fcf gui=none
hi Identifier guifg=#FFCC00
hi PreProc guifg=#fcaf3e
hi Function guifg=#fcaf3e
hi Type guifg=Red gui=none
hi Keyword guifg=#eeeeec
hi Special guifg=#888a85
hi Error guifg=#eeeeec guibg=#cc0000
hi Structure guifg=#AAFFFF
hi Include guifg=#AAFFFF
hi String guifg=#66FF00

" PHP
hi phpRegionDelimiter guifg=#ad7fa8
hi phpPropertySelector guifg=#888a85
hi phpPropertySelectorInString guifg=#888a85
hi phpOperator guifg=#888a85
hi phpArrayPair guifg=#888a85
hi phpAssignByRef guifg=#888a85
hi phpRelation guifg=#888a85
hi phpMemberSelector guifg=#888a85
hi phpUnknownSelector guifg=#888a85
hi phpVarSelector guifg=#babdb6
hi phpSemicolon guifg=#888a85 gui=none
hi phpFunctions guifg=#d3d7cf
hi phpParent guifg=#888a85

" JavaScript
hi javaScriptBraces guifg=#888a85
hi javaScriptOperator guifg=#888a85

" HTML
hi htmlTag guifg=#888a85
hi htmlEndTag guifg=#888a85
hi htmlTagName guifg=#babdb6
hi htmlSpecialTagName guifg=#babdb6
hi htmlArg guifg=#d3d7cf
hi htmlTitle guifg=#8ae234 gui=none
hi link htmlH1 htmlTitle
hi link htmlH2 htmlH1
hi link htmlH3 htmlH1
hi link htmlH4 htmlH1
hi link htmlH5 htmlH1
hi link htmlH6 htmlH1

" XML
hi link xmlTag htmlTag
hi link xmlEndTag htmlEndTag
hi link xmlAttrib htmlArg

" CSS
hi cssSelectorOp guifg=#eeeeec
hi link cssSelectorOp2 cssSelectorOp
hi cssUIProp guifg=#d3d7cf
hi link cssPagingProp cssUIProp
hi link cssGeneratedContentProp cssUIProp
hi link cssRenderProp cssUIProp
hi link cssBoxProp cssUIProp
hi link cssTextProp cssUIProp
hi link cssColorProp cssUIProp
hi link cssFontProp cssUIProp
hi cssPseudoClassId guifg=#eeeeec
hi cssBraces guifg=#888a85
hi cssIdentifier guifg=#fcaf3e
hi cssTagName guifg=#fcaf3e
hi link cssInclude Function
hi link cssCommonAttr Constant
hi link cssUIAttr Constant
hi link cssTableAttr Constant
hi link cssPagingAttr Constant
hi link cssGeneratedContentAttr Constant
hi link cssAuralAttr Constant
hi link cssRenderAttr Constant
hi link cssBoxAttr Constant
hi link cssTextAttr Constant
hi link cssColorAttr Constant
hi link cssFontAttr Constant

" Diff
hi DiffAdd    guibg=Green
hi DiffDelete guibg=Red
hi DiffChange guibg=Yellow
hi DiffText   guibg=Blue
