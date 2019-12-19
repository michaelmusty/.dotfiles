" Entry point for plugin
function! spellfile_local#() abort

  " If this is a special buffer, don't do anything
  if index(['nofile', 'quickfix', 'help'], &buftype) >= 0
    return
  endif

  " Get the first item in the spelling languages list, bail if there aren't
  " any; strip any regional suffix (e.g. en_NZ), too, as the final 'spellfile'
  " value won't tolerate it
  "
  let spelllangs = s:OptionSplit(&spelllang)
  if len(spelllangs) == 0
    return
  endif
  let lang = split(spelllangs[0], '_')[0]

  " Use current encoding
  let encoding = &encoding

  " Start a list of spellfiles
  let spellfiles = []

  " Imitate Vim's behaviour in creating a `spell` subdir in the first
  " writeable element of 'runtimepath'
  "
  for runtimepath in s:OptionSplit(&runtimepath)
    let path = s:Path(join(add(
          \ split(runtimepath, '/', 1)
          \,'spell'
          \), '/'), lang, encoding)
    if path !=# ''
      call add(spellfiles, path)
      break
    endif
  endfor

  " Still no 'spellfile'?  Quietly give up
  if len(spellfiles) == 0
    return
  endif

  " Get the path to the spelling files directory
  let dir = fnamemodify(spellfiles[0], ':h')

  " Specify the name and type of spelling files we'll add, with a list of
  " two-key dictionaries.  For each of these, the `name` is used as the
  " subdirectory, and the `value` as the first component of the filename.  We
  "
  let types = [
        \ { 'name': 'path', 'value': expand('%:p') }
        \,{ 'name': 'filetype', 'value': &filetype }
        \]

  " Iterate through the specified types to add them to the spelling files list
  for type in types

    " Add a new calculated path to the spellfiles list, if valid
    let spellfile = s:Path(dir, lang, encoding, type)
    if spellfile !=# ''
      call add(spellfiles, spellfile)
    endif

  endfor

  " Set the spellfile path list to the concatenated list
  let &spellfile = s:OptionJoin(spellfiles)

endfunction

" Escape a path for use as a valid spelling file name; replace any characters
" not in 'isfname' with percent symbols
function! s:Escape(filename) abort
  let filename = ''
  for char in split(a:filename, '\zs')
    if char !=# '_' && char !=# '/' && char =~# '^\f$'
      let filename .= char
    else
      let filename .= '%'
    endif
  endfor
  return filename
endfunction

" Ensure a directory exists, or create it
function! s:Establish(path) abort
  return isdirectory(a:path)
        \ || exists('*mkdir') && mkdir(a:path, 'p', 0700)
endfunction

" Join a list of strings into a comma-separated option
function! s:OptionJoin(list) abort
  return join(map(
        \ a:list
        \,'substitute(v:val, ''\\\@<!,'', ''\\,'', ''g'')'
        \), ',')
endfunction

" Split a comma-separated option into a list of strings
function! s:OptionSplit(string) abort
  return map(
        \ split(a:string, '\\\@<!,[, ]*')
        \,'substitute(v:val, ''\\,'', '''', ''g'')'
        \)
endfunction

" Given a directory, language, encoding, and optionally a type with
" subdirectory and filename value to extend it, calculate a path, ensuring
" that the relevant directory is created; otherwise return nothing
"
function! s:Path(dir, lang, encoding, ...) abort

  " Pull in the type variable if it was defined
  if a:0 > 0
    let type = a:1
  endif

  " Make lists representing the directory path elements and the
  " period-separated filename
  "
  let dir = split(a:dir, '/', 1)
  let file = [a:lang, a:encoding, 'add']

  " If we have an optional type, extend the directory with another element
  " according to its name, and insert the value before the filename,
  " e.g. append "filetype" to the directory, and insert the current value of
  " &filetype before the filename; if we have a type but a blank value, which
  " is not necessarily an error condition, stop here and return nothing
  "
  if exists('type')
    if type['value'] ==# ''
      return
    endif
    call add(dir, type['name'])
    call insert(file, type['value'])
  endif

  " Ensure the directory is in place, trying to create it if need be, and that
  " all of it passes an 'isfname' filter, since 'spellfile' checks that
  "
  let ds = join(dir, '/')
  if ds !~# '^\f\+$'
        \ || filewritable(ds) != 2 && !mkdir(ds, '0700', 'p')
    return
  endif

  " Build the full spellfile path, escaping the filename appropriately, and
  " return it as a path string
  "
  let path = add(copy(dir), s:Escape(join(file, '.')))
  return join(path, '/')

endfunction
