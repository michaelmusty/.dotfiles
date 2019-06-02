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
