" Vim syntax file
" Language: SugarML
" Maintainer: Caleb Eby
" Credits: Joshua Borton, Tim Pope
" Filenames: *.sgr

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'sugarml'
endif

silent! syntax include @htmlJavascript syntax/javascript.vim
unlet! b:current_syntax

syn case match

syn region  javascriptParenthesisBlock start="(" end=")" contains=@htmlJavascript contained keepend
syn cluster htmlJavascript add=javascriptParenthesisBlock

syn region  sugarmlJavascript matchgroup=sugarmlJavascriptOutputChar start="[!&]\==\|\~" skip=",\s*$" end="$" contained contains=@htmlJavascript keepend
syn cluster sugarmlTop contains=sugarmlBegin,sugarmlComment,sugarmlHtmlComment,sugarmlJavascript
syn match   sugarmlBegin "^\s*\%([<>]\|&[^=~ ]\)\@!" nextgroup=sugarmlTag,sugarmlClassChar,sugarmlIdChar,sugarmlPlainChar,sugarmlJavascript,sugarmlScriptConditional,sugarmlScriptStatement,sugarmlPipedText
syn match   sugarmlTag "+\?[[:alnum:]_-]\+\%(:\w\+\)\=" contained contains=htmlTagName,htmlSpecialTagName nextgroup=@sugarmlComponent
syn cluster sugarmlComponent contains=sugarmlAttributes,sugarmlIdChar,sugarmlBlockExpansionChar,sugarmlClassChar,sugarmlPlainChar,sugarmlJavascript,sugarmlTagBlockChar,sugarmlTagInlineText
syntax keyword sugarmlCommentTodo  contained TODO FIXME XXX TBD
syn match   sugarmlComment '\(\s\+\|^\)\/\/.*$' contains=sugarmlCommentTodo,@Spell
syn region  sugarmlCommentBlock start="\z(\s\+\|^\)\/\/.*$" end="^\%(\z1\s\|\s*$\)\@!" contains=sugarmlCommentTodo,@Spell keepend
syn region  sugarmlHtmlConditionalComment start="<!--\%(.*\)>" end="<!\%(.*\)-->" contains=sugarmlCommentTodo,@Spell
syn region  sugarmlAngular2 start="(" end=")" contains=htmlEvent
syn region  sugarmlJavascriptString start=+"+  skip=+\\\("\|$\)+  end=+"\|$+ contained contains=sugarmlInterpolation
syn region  sugarmlJavascriptString start=+'+  skip=+\\\('\|$\)+  end=+'\|$+ contained contains=sugarmlInterpolation
syn region  sugarmlAttributes matchgroup=sugarmlAttributesDelimiter start="(" end=")" contained contains=sugarmlJavascriptString,sugarmlHtmlArg,sugarmlAngular2,htmlArg,htmlEvent,htmlCssDefinition nextgroup=@sugarmlComponent
syn match   sugarmlClassChar "\." containedin=htmlTagName nextgroup=sugarmlClass
syn match   sugarmlBlockExpansionChar ":\s\+" contained nextgroup=sugarmlTag,sugarmlClassChar,sugarmlIdChar
syn match   sugarmlIdChar "#[[{]\@!" contained nextgroup=sugarmlId
syn match   sugarmlClass "\%(\w\|-\)\+" contained nextgroup=@sugarmlComponent
syn match   sugarmlId "\%(\w\|-\)\+" contained nextgroup=@sugarmlComponent
syn region  sugarmlDocType start="^\s*\(!!!\|doctype\)" end="$"
syn match   sugarmlPlainChar "\\" contained
syn region  sugarmlInterpolation matchgroup=sugarmlInterpolationDelimiter keepend start="{{" end="}}" contains=@htmlJavascript
syn match   sugarmlTagInlineText "\s.*$" contained contains=sugarmlInterpolation,sugarmlTextInlinesugarml,@Spell
syn region  sugarmlPipedText matchgroup=sugarmlPipeChar start="|" end="$" contained contains=sugarmlInterpolation,sugarmlTextInlinesugarml nextgroup=sugarmlPipedText skipnl
syn match   sugarmlTagBlockChar "\.$" contained nextgroup=sugarmlTagBlockText,sugarmlTagBlockEnd skipnl
syn region  sugarmlTagBlockText start="\%(\s*\)\S" end="\ze\n" contained contains=sugarmlInterpolation,sugarmlTextInlinesugarml,@Spell nextgroup=sugarmlTagBlockText,sugarmlTagBlockEnd skipnl
syn region  sugarmlTagBlockEnd start="\s*\S" end="$" contained contains=sugarmlInterpolation,sugarmlTextInlinesugarml nextgroup=sugarmlBegin skipnl

syn match  sugarmlError "\$" contained

hi def link sugarmlPlainChar              Special
hi def link sugarmlScriptConditional      PreProc
hi def link sugarmlScriptLoopKeywords     PreProc
hi def link sugarmlScriptStatement        PreProc
hi def link sugarmlHtmlArg                htmlArg
hi def link sugarmlTag                    htmlTagName
hi def link sugarmlAttributeString        String
hi def link sugarmlAttributesDelimiter    Identifier
hi def link sugarmlIdChar                 Special
hi def link sugarmlClassChar              Special
hi def link sugarmlBlockExpansionChar     Special
hi def link sugarmlPipeChar               Special
hi def link sugarmlTagBlockChar           Special
hi def link sugarmlId                     Identifier
hi def link sugarmlClass                  Type
hi def link sugarmlInterpolationDelimiter Delimiter
hi def link sugarmlInlineDelimiter        Delimiter
hi def link sugarmlFilter                 PreProc
hi def link sugarmlDocType                Comment
hi def link sugarmlCommentTodo            Todo
hi def link sugarmlComment                Comment
hi def link sugarmlCommentBlock           Comment
hi def link sugarmlHtmlConditionalComment sugarmlComment
hi def link sugarmlJavascriptString       String
hi def link sugarmlAttributes             htmlArg

let b:current_syntax = "sugarml"

if main_syntax == "sugarml"
  unlet main_syntax
endif
