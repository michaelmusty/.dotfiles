"
" mail_mutt.vim: Start a mutt(1) message with the lines in the given range,
" defaulting to the entire buffer.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
" License: Same as Vim itself
"
if exists('g:loaded_mail_mutt') || &compatible || !has('user_commands')
  finish
endif
let g:loaded_mail_mutt = 1

" Declare function
function! s:MailMutt(start, end)

  " Check we'll have mutt(1) to execute
  if !executable('mutt')
    echoerr 'mutt not found in $PATH'
    finish
  endif

  " Create a temporary file
  let l:tf = tempname()

  " Write the contents of the buffer to it
  let l:range = a:start . ',' . a:end
  let l:command = 'write ' . fnameescape(l:tf)
  execute l:range . l:command


  " Run mutt(1) with that file as its input
  execute '!mutt -i ' . shellescape(l:tf)

endfunction

" Create a command to wrap around that function
command -nargs=0 -range=%
      \ MailMutt 
      \ call <SID>MailMutt(<line1>, <line2>)

" Mapping to mail current line in normal mode
nnoremap <silent> <unique>
      \ <Plug>MailMuttLine
      \ :<C-U>.MailMutt<CR>

" Mapping to mail whole buffer in normal mode
nnoremap <silent> <unique>
      \ <Plug>MailMuttBuffer
      \ :<C-U>%MailMutt<CR>

" Mapping to mail selected lines in visual/select mode
vnoremap <silent> <unique>
      \ <Plug>MailMuttSelected
      \ :MailMutt<CR>
