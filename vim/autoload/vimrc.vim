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

" Expand the first path in an option string, check if it exists, and attempt
" to create it if it doesn't.  Strip double-trailing-slash hints.
function! vimrc#Establish(string) abort
  let part = vimrc#SplitOption(a:string)[0]
  let part = substitute(part, '//$', '', '')
  let dirname = expand(part)
  return isdirectory(dirname)
        \ || mkdir(dirname, 'p')
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

  " Test the version string and get submatches for each part
  let match = matchlist(a:string, '^\(\d\+\)\.\(\d\+\)\.\(\d\+\)$')

  " Throw toys if the string didn't match the expected format
  if !len(match)
    echoerr 'Invalid version string: '.a:string
    return
  endif

  " Get the major, minor, and patch numbers from the submatches
  let [major, minor, patch] = match[1:3]

  " Create a string like 801 from a version number 8.1 to compare it to the
  " v:version integer
  let ver = major * 100 + minor

  " Compare versions
  return v:version > ver
        \ || v:version == ver && has('patch'.patch)

endfunction
