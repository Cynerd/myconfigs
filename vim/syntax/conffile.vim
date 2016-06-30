" Vim syntax file
" Language:     C
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last Change:  2013 Jul 05

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

left s:ft = matchstr(&ft, '^\([^.]\)\+')

syn match 	sComment	"#.*$"
syn keyword 	sKeywords 	typedef menu group endmenu endgroup type menu default menu visible nodefault
syn keyword 	sKWCondition 	dependency default
syn keyword 	sTypes 		int bool string hex float
syn region 	sString 	start=+\"+ skip=+\\.+ end=+\"+

syn keyword 	sKeywords 	output nextgroup=sOutput
syn region 	sOutput 	start="\w\+ \+{" end="}" contains=covariable,cocommand,coifcommand,CoNone
syn match 	sOutput 	"\w\+ \+\w\+" 
syn match 	covariable 	"\$\w\+" contained
syn match 	cocommand	"\$\(endif\|else\)" contained
syn region 	CoNone 		matchgroup=coifcommand start=+\$\(if\|elif\|ifdep\)(+ end=+)+ contains=covariable,sKWCondition contained


hi def link sComment 		Comment
hi def link sKeywords 		Precondit
hi def link sKWCondition 	sKeywords
hi def link sTypes 		Statement
hi def link sString 		String

hi def link cocommand 		Macro
hi def link coifcommand		Macro
hi def link covariable 		Identifier

let b:current_syntax = "conffile"
