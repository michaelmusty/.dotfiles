"
" sahara, a 256-color retake on desert256 with the color detection code
" removed for clarity. Written by Tom Ryder (tyrmored).
"
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
"

"
" Terminal setup.
"
set background=dark
if version > 580
    highlight clear
    if exists("g:syntax_on")
        syntax reset
    endif
endif
let g:colors_name="dessert"

"
" Highlighting definitions.
"
if has("gui_running") || &t_Co == 256
    highlight Comment      cterm=NONE ctermfg=110 ctermbg=16  gui=NONE guifg=#87afd7 guibg=#000000
    highlight Constant     cterm=NONE ctermfg=217 ctermbg=16  gui=NONE guifg=#ffafaf guibg=#000000
    highlight Cursor       cterm=NONE ctermfg=66  ctermbg=222 gui=NONE guifg=#5f8787 guibg=#ffd787
    highlight FoldColumn   cterm=NONE ctermfg=180 ctermbg=237 gui=NONE guifg=#d7af87 guibg=#3a3a3a
    highlight Folded       cterm=NONE ctermfg=220 ctermbg=237 gui=NONE guifg=#ffd700 guibg=#3a3a3a
    highlight Identifier   cterm=NONE ctermfg=120 ctermbg=16  gui=NONE guifg=#87ff87 guibg=#000000
    highlight Ignore       cterm=NONE ctermfg=240 ctermbg=16  gui=NONE guifg=#585858 guibg=#000000
    highlight IncSearch    cterm=NONE ctermfg=147 ctermbg=24  gui=NONE guifg=#afafff guibg=#005f87
    highlight ModeMsg      cterm=NONE ctermfg=178 ctermbg=16  gui=NONE guifg=#d7af00 guibg=#000000
    highlight MoreMsg      cterm=NONE ctermfg=29  ctermbg=16  gui=NONE guifg=#00875f guibg=#000000
    highlight NonText      cterm=NONE ctermfg=237 ctermbg=16  gui=NONE guifg=#3a3a3a guibg=#000000
    highlight Normal       cterm=NONE ctermfg=251 ctermbg=16  gui=NONE guifg=#c6c6c6 guibg=#000000
    highlight Pmenu        cterm=NONE ctermfg=231 ctermbg=237 gui=NONE guifg=#ffffff guibg=#3a3a3a
    highlight PreProc      cterm=NONE ctermfg=167 ctermbg=16  gui=NONE guifg=#d75f5f guibg=#000000
    highlight Question     cterm=NONE ctermfg=48  ctermbg=16  gui=NONE guifg=#00ff87 guibg=#000000
    highlight Search       cterm=NONE ctermfg=147 ctermbg=17  gui=NONE guifg=#afafff guibg=#000087
    highlight Special      cterm=NONE ctermfg=223 ctermbg=16  gui=NONE guifg=#ffd7af guibg=#000000
    highlight SpecialKey   cterm=NONE ctermfg=112 ctermbg=16  gui=NONE guifg=#87d700 guibg=#000000
    highlight Statement    cterm=NONE ctermfg=222 ctermbg=16  gui=NONE guifg=#ffd787 guibg=#000000
    highlight StatusLine   cterm=NONE ctermfg=231 ctermbg=237 gui=NONE guifg=#ffffff guibg=#3a3a3a
    highlight StatusLineNC cterm=NONE ctermfg=16  ctermbg=237 gui=NONE guifg=#000000 guibg=#3a3a3a
    highlight Title        cterm=NONE ctermfg=244 ctermbg=237 gui=NONE guifg=#808080 guibg=#3a3a3a
    highlight Todo         cterm=NONE ctermfg=196 ctermbg=226 gui=NONE guifg=#ff0000 guibg=#ffff00
    highlight Type         cterm=NONE ctermfg=143 ctermbg=16  gui=NONE guifg=#afaf5f guibg=#000000
    highlight Underlined   cterm=NONE ctermfg=81  ctermbg=16  gui=NONE guifg=#5fd7ff guibg=#000000
    highlight VertSplit    cterm=NONE ctermfg=243 ctermbg=237 gui=NONE guifg=#767676 guibg=#3a3a3a
    highlight Visual       cterm=NONE ctermfg=222 ctermbg=64  gui=NONE guifg=#ffd787 guibg=#5f8700
    highlight WarningMsg   cterm=NONE ctermfg=209 ctermbg=16  gui=NONE guifg=#ff875f guibg=#000000
    highlight! link LineNr      NonText
    highlight! link TabLine     StatusLineNC
    highlight! link TabLineFill StatusLineNC
    highlight! link TabLineSel  StatusLine
    highlight! link VertSplit   StatusLineNC
    highlight! link VimHiGroup  VimGroup
endif

