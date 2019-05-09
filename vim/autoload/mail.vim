" Add a header to a mail message
function! mail#AddHeaderField(name, body) abort
  let num = 0
  while num < line('$') && getline(num + 1) !=# ''
    let num += 1
  endwhile
  call append(num, a:name.': '.a:body)
endfunction

" Add a set of headers to a mail message
function! mail#AddHeaderFields(fields) abort
  for name in sort(keys(a:fields))
    call mail#AddHeaderField(name, a:fields[name])
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
  let block = 0

  " Flag for the number of blocks passed
  let blocks = 0

  " Iterate through buffer lines
  let num = line('.')
  while a:up ? num > 1 : num < line('$')

    " If the line is blank
    if getline(num) =~# '^[ >]*$'

      " If we'd moved through a non-blank block already, reset that flag and
      " bump up the block count
      if block
        let block = 0
        let blocks += 1
      endif

      " If we've hit the number of blocks, end the loop
      if blocks == a:count
        break
      endif

    " If the line is not blank, flag that we're going through a block
    else
      let block = 1
    endif

    " Move the line number or up or down depending on direction
    let num += a:up ? -1 : 1

  endwhile

  " Move to line if nonzero and not equal to the current line
  if num != line('.')
    execute 'normal '.num.'G'
  endif

endfunction
