" Add a header to a mail message
function! mail#AddHeaderField(name, body) abort
  let l:num = 0
  while l:num < line('$') && getline(l:num + 1) !=# ''
    let l:num += 1
  endwhile
  call append(l:num, a:name.': '.a:body)
endfunction

" Add a set of headers to a mail message
function! mail#AddHeaderFields(fields) abort
  for l:name in sort(keys(a:fields))
    call mail#AddHeaderField(l:name, a:fields[l:name])
  endfor
endfunction

" Flag a message as important
function! mail#FlagImportant() abort
  call mail#AddHeaderFields({
        \ 'Importance': 'High',
        \ 'X-Priority': 1
        \ })
endfunction

" Flag a message as unimportant
function! mail#FlagUnimportant() abort
  call mail#AddHeaderFields({
        \ 'Importance': 'Low',
        \ 'X-Priority': 5
        \ })
endfunction

" Move through quoted paragraphs like normal-mode `{` and `}`
function! mail#NewBlank(count, up, visual) abort

  " Reselect visual selection
  if a:visual
    normal! gv
  endif

  " Flag for whether we've started a block
  let l:block = 0

  " Flag for the number of blocks passed
  let l:blocks = 0

  " Iterate through buffer lines
  let l:num = line('.')
  while a:up ? l:num > 1 : l:num < line('$')

    " If the line is blank
    if getline(l:num) =~# '^[ >]*$'

      " If we'd moved through a non-blank block already, reset that flag and
      " bump up the block count
      if l:block
        let l:block = 0
        let l:blocks += 1
      endif

      " If we've hit the number of blocks, end the loop
      if l:blocks == a:count
        break
      endif

    " If the line is not blank, flag that we're going through a block
    else
      let l:block = 1
    endif

    " Move the line number or up or down depending on direction
    let l:num += a:up ? -1 : 1

  endwhile

  " Move to line if nonzero and not equal to the current line
  if l:num != line('.')
    execute 'normal '.l:num.'G'
  endif

endfunction
