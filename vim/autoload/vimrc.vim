" Escape a text value for inclusion in an option value
function! vimrc#EscapeSet(string) abort
  return escape(a:string, '\ |"')
endfunction

" Escape a text value for inclusion as an element in a comma-separated list
" option value.  Yes, the comma being the sole inner escaped character here is
" correct.  No, we don't escape backslash itself.  Yes, that means it's
" impossible to have the literal string '\,' in a part.
function! vimrc#EscapeSetPart(string) abort
  return vimrc#EscapeSet(escape(a:string, ','))
endfunction

" Check that we have a plugin available, and will be loading it
function! vimrc#PluginReady(filename) abort
  return globpath(&runtimepath, 'plugin/'.a:filename.'.vim') !=# ''
        \ && &loadplugins
endfunction

" Split a comma-separated option string into its constituent parts, imitating
" copy_option_part() in the Vim sources.  No, I'm not going to use some insane
" regular expression.  Who do you think I am, Tim Pope?
function! vimrc#SplitOption(str) abort

  " Specify escaping and separating characters
  let esc = '\'
  let sep = ','

  " Get string and its length into local variable
  let str = a:str
  let len = strlen(str)

  " Prepare list of parts and a variable to hold each part as it's built
  let parts = []
  let part = ''

  " Start the index
  let idx = 0

  " Iterate through string; we use a while loop because we might be skipping
  " over characters
  while idx < len

    " Get the character at this index
    let char = str[idx]

    " Examine this character and possibly the one following it
    if char ==# esc && str[idx+1] ==# sep

      " If this is the escape character *and* the following character is the
      " separator character, add the separator character to the part, and skip
      " to the character after that for the next iteration.  Note that if the
      " following character is *not* the separator character, that means we add
      " the escape character literally.  This is deliberate, and is exactly
      " what Vim does!
      let part .= sep
      let idx += 2

    elseif char ==# sep

      " If this is the separator character, we can add the list part we've
      " built (even if it's blank) to the list of parts, and start a new one
      call add(parts, part)
      let part = ''
      let idx += 1

    else

      " Just add this character literally, there's nothing special about it
      let part .= char
      let idx += 1

    endif

  endwhile

  " Pass the list of collected string parts to the caller.  It might be empty,
  " or contain zero-length strings; neither are error conditions.
  return parts

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
