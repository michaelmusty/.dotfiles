function! s:SplitOption(string) abort
  return map(
      \ split(a:string, '\\\@<!,[, ]*')
      \,'substitute(v:val, ''\\,'', '''', ''g'')'
      \)
endfunction

function! s:JoinOption(list) abort
  return join(map(
        \ a:list
        \,'substitute(v:val, ''\\\@<!,'', ''\\,'', ''g'')'
        \), ',')
endfunction

function! s:Establish(path) abort
  return isdirectory(a:path)
        \ || exists('*mkdir') && mkdir(a:path, 'p', 0700)
endfunction

function! spellfile_local#() abort

  set spellfile<

  let spelllangs = s:SplitOption(&spelllang)
  if !len(spelllangs) || &spelllang[0] ==# ''
    echoerr 'Blank ''spelllang'''
  endif
  let spelllang = substitute(spelllangs[0], '_.*', '', '')

  if !len(&encoding)
    echoerr 'Blank ''encoding'''
  endif

  let spellfiles = s:SplitOption(&spellfile)
  if len(spellfiles) != 1 || spellfiles[0] ==# ''
    return
  endif

  let spelldir = fnamemodify(spellfiles[0], ':h')
  if spelldir ==# ''
    echoerr 'Blank directory'
  endif

  try
    let path = substitute(expand('%:p'), '/', '%', 'g')
    if path ==# ''
      echoerr 'Blank path'
    endif
    call s:Establish(spelldir.'/path')
    call add(spellfiles, spelldir.'/path/'.join([
          \ path
          \,spelllang
          \,&encoding
          \,'add'
          \], '.'))

    if &filetype ==# ''
      echoerr 'Blank filetype'
    endif
    call s:Establish(spelldir.'/filetype')
    call add(spellfiles, spelldir.'/filetype/'.join([
          \ &filetype
          \,spelllang
          \,&encoding
          \,'add'
          \], '.'))
  catch
  endtry

  let &l:spellfile = s:JoinOption(spellfiles)

endfunction
