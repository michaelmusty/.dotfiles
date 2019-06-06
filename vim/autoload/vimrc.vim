" Escape a text value for :execute-based :set inclusion in an option
function! vimrc#EscapeSet(string) abort
  return escape(a:string, '\ |"')
endfunction

" Escape a text value for inclusion as an element in a comma-separated list
" option.  Yes, the comma being the sole inner escaped character here is
" correct.  No, we shouldn't escape backslash itself.  Yes, that means it's
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
" copy_option_part() in the Vim sources.  This isn't perfect, but it should be
" more than good enough.  A separator can be defined as: a comma that is not
" preceded by a backslash, and which is followed by any number of spaces
" and/or further commas.
function! vimrc#SplitOption(string) abort
  return split(a:string, '\\\@<!,[, ]*')
endfunction

" Convenience version function check that should work with 7.0 or newer;
" takes strings like 7.3.251
function! vimrc#Version(string) abort

  " Throw toys if the string doesn't match the expected format
  if a:string !~# '^\d\+\.\d\+\.\d\+$'
    echoerr 'Invalid version string: '.a:string
  endif

  " Split version string into major, minor, and patch level integers
  let [major, minor, patch] = split(a:string, '\.')

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
