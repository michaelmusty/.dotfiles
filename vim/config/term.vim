" Don't bother about checking whether Escape is being used as a means to enter
" a Meta-key combination, just register Escape immediately
set noesckeys

" Don't bother drawing the screen while executing macros or other automated or
" scripted processes, just draw the screen as it is when the operation
" completes
set lazyredraw

" Improve redrawing smoothness by assuming that my terminal is reasonably
" fast
set ttyfast

" Never use any kind of bell, visual or not
set visualbell t_vb=

" Require less than one second between keys for mappings to work correctly
set timeout
set timeoutlen=1000

" Require less than a twentieth of a second between keys for key codes to work
" correctly; I don't use Escape as a meta key anyway
set ttimeout
set ttimeoutlen=50

" Don't write the output of :make to the terminal
set shellpipe=>
