" Escape a text value for inclusion in a comma-separated option value
function! vimrc#EscapeSet(string)
  return escape(a:string, '\ ,')
endfunction

" Split a string with a split character that can be escaped with another,
" e.g. &runtimepath with commas and backslashes respectively
function! vimrc#SplitEscaped(str, ...) abort

  " Arguments to function
  let str = a:str                 " String to split
  let sep = a:0 >= 1 ? a:1 : ','  " Optional split char, default comma
  let esc = a:0 >= 2 ? a:2 : '\'  " Optional escape char, default backslash

  " Get length of string, return empty list if it's zero
  let len = strlen(str)
  if !len
    return []
  endif

  " Collect items into list by iterating characterwise
  let list = ['']  " List items
  let idx = 0      " Offset in string
  while idx < len

    if str[idx] ==# sep

      " This character is the item separator, and it wasn't escaped; start a
      " new list item
      call add(list, '')

    else

      " This character is the escape character, so we'll skip to the next
      " character, if any, and add that; testing suggests that a terminal
      " escape character on its own shouldn't be added
      if str[idx] ==# esc
        let idx += 1
      endif
      let list[-1] .= str[idx]

    endif

    " Bump index for next character
    let idx += 1

  endwhile

  " Return the completed list
  return list

endfunction

" Convenience version function check that should work with 7.0 or newer;
" takes strings like 7.3.251
function! vimrc#Version(verstr) abort

  " Throw toys if the string doesn't match the expected format
  if a:verstr !~# '^\d\+\.\d\+.\d\+$'
    echoerr 'Invalid version string: '.a:verstr
  endif

  " Split version string into major, minor, and patch level integers
  let [major, minor, patch] = split(a:verstr, '\.')

  " Create a string like 801 from a version number 8.1 to compare it to
  " the v:version integer
  let ver = major * 100 + minor

  " Compare versions
  if v:version > ver
    return 1  " Current Vim is newer than the wanted one
  elseif ver < v:version
    return 0  " Current Vim is older than the wanted one
  else
    return has('patch'.patch)  " Versions equal, return patch presence
  endif

endfunction
