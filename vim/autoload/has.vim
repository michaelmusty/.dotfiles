" Wrapper to backport the nicer has() syntax for simultaneous version and
" patch level checking that was introduced in v7.4.236 and fixed in v7.4.237.
"
" * <https://github.com/vim/vim/releases/tag/v7.4.236>
" * <https://github.com/vim/vim/releases/tag/v7.4.237>
"
function! has#(feature) abort

  " If we're new enough, we can just run the native has()
  if has('patch-7.4.237')
    return has(a:feature)
  endif

  " Otherwise, we have to break down the pattern and do manual version and
  " patch level checks; if it doesn't match the patch syntax, just return what
  " the native has() does
  "
  let feature = a:feature
  let pattern = '^patch-\(\d\+\)\.\(\d\+\)\.\(\d\+\)$'
  let matchlist = matchlist(feature, pattern)
  if empty(matchlist)
    return has(a:feature)
  endif
  let [major, minor, patch] = matchlist[1:3]

  " The v:version variable looks like e.g. 801 for v8.1
  let l:version = major * 100 + minor

  " Compare the version numbers, and then the patch level if they're the same
  return v:version != l:version
        \ ? v:version > l:version
        \ : has('patch-'.patch)

endfunction
