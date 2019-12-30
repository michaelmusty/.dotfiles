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
        \ 'X-Priority': 1,
        \ })
endfunction

" Flag a message as unimportant
function! mail#FlagUnimportant() abort
  call mail#AddHeaderFields({
        \ 'Importance': 'Low',
        \ 'X-Priority': 5,
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

function! mail#StrictQuote(start, end) abort
  let body = 0
  for lnum in range(a:start, a:end)

    " Get current line
    let line = getline(lnum)

    " Get the leading quote string, if any; skip if there isn't one
    let quote = matchstr(line, '^>[> ]*')
    if !strlen(quote)
      continue
    endif

    " Normalise the quote with no spaces
    let quote = substitute(quote, '[^>]', '', 'g')

    " Re-set the line
    let line = substitute(line, '^[> ]\+', quote, '')
    call setline(lnum, line)

  endfor
endfunction

" Attempt to move to a good spot to start writing
function! mail#SuggestStart() abort

  " Move to top of buffer
  call setpos('.', [0, 1, 1, 0])

  " Move to body text
  call search('\m^$', 'c') | +

  " Start by trying to move to the first quoted line; this may fail if there's
  " no quote, which is fine
  call search('\m^>', 'c')

  " Delete quoted blank lines or quoted greetings until we get to something
  " with substance.  Yes, I like Perl, how could you tell?
  while getline('.') =~? '^> *'
        \ . '\%('
          \ . '\%('
            \ . 'g[''\u2019]\=day'
            \ . '\|\%(good \)\=\%(morning\|afternoon\|evening\)'
            \ . '\|h[eu]\%(ll\|rr\)o\+'
            \ . '\|hey\+'
            \ . '\|hi\+'
            \ . '\|sup'
            \ . '\|what[''\u2019]\=s up'
            \ . '\|yo'
          \ . '\)'
          \ . '[[:punct:] ]*'
          \ . '\%('
            \ . '\a\+'
            \ . '[[:punct:] ]*'
          \ . '\)\='
        \ . '\)\=$'
    delete
  endwhile

  " Now move to the first quoted or unquoted blank line
  call search('\m^>\= *$', 'c')
endfunction
