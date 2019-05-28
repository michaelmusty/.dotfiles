" Remove special highlighting for double-quoted strings in comments
syntax clear vimCommentString

" Highlight :CompilerSet commands like :set/:setlocal, but only in compiler
" scripts in recognisable paths
if expand('%:h:t') ==# 'compiler'
      \ && expand('%:e') ==# 'vim'
  syntax keyword vimCommand contained
        \ CompilerSet
  syntax region vimSet matchgroup=vimCommand
        \ start="\<CompilerSet\>"
        \ end="$" end="|" end="<[cC][rR]>"
        \ keepend
        \ matchgroup=vimNotation
        \ oneline
        \ skip="\%(\\\\\)*\\."
        \ contains=vimSetEqual
        \,vimOption
        \,vimErrSetting
        \,vimComment
        \,vimSetString
        \,vimSetMod
endif
