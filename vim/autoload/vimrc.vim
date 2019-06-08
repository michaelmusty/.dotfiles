" Utility functions for use in .vim/vimrc only

" Expand the first path in an option string, check if it exists, and attempt
" to create it if it doesn't.  Strip double-trailing-slash hints.
function! vimrc#Ensure(string) abort

  " Get first part of the option string
  let part = vimrc#SplitOption(a:string)[0]

  " Remove any trailing slashes; neither expand() nor mkdir() seems bothered,
  " at least on Unix, but let's be tidy anyway
  let part = substitute(part, '/\+$', '', '')

  " Expand the directory name to replace tildes with the home directory, but
  " it still may not necessarily be an absolute path
  let dirname = expand(part)

  " Return either the confirmed presence of the directory, or failing that,
  " the result of an attempt to create it
  return isdirectory(dirname)
        \ || mkdir(dirname, 'p')

endfunction

" Check that we have a plugin available, and will be loading it
function! vimrc#PluginReady(filename) abort

  " Return whether the given filename with a .vim extension is present in
  " a subdirectory named 'plugin', and that the 'loadplugins' option is on,
  " implying that Vim will at least attempt to load it
  let path = 'plugin/'.a:filename.'.vim'
  return globpath(&runtimepath, path) !=# ''
        \ && &loadplugins

endfunction

" Split a comma-separated option string into its constituent parts
function! vimrc#SplitOption(string) abort

  " A separator can be defined as: a comma that is not preceded by
  " a backslash, and which is followed by any number of spaces and/or further
  " commas.  No, I don't have to deal with escaped backslashes; read the
  " source of copy_option_part() in vim/src/misc2.c to see why.
  let pattern
        \ = '\\\@<!'
        \ . ','
        \ . '[, ]*'
  return split(a:string, pattern)

endfunction

" Convenience version function check that should work with 7.0 or newer;
" takes strings like 7.3.251
function! vimrc#Version(string) abort

  " Test the version string and get submatches for each part
  let pattern
        \ = '^'
        \ . '\(\d\+\)'
        \ . '\.'
        \ . '\(\d\+\)'
        \ . '\.'
        \ . '\(\d\+\)'
        \ . '$'
  let match = matchlist(a:string, pattern)

  " Throw toys if the string didn't match the expected format
  if !len(match)
    echoerr 'Invalid version string: '.a:string
    return
  endif

  " Create a version integer like 801 from a version number 8.1, and a patch
  " level string from the patch number
  let running = match[1] * 100 + match[2]
  let patch = 'patch'.match[3]

  " Compare versions
  return v:version > running
        \ || v:version == running && has(patch)

endfunction
