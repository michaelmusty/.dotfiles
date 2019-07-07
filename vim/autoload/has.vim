function! has#(feature) abort
  if has('patch-7.4.237')
    return has(a:feature)
  endif
  let feature = a:feature
  let pattern = 'patch-\(\d\+\)\.\(\d\+\)\.\(\d\+\)'
  let matchlist = matchlist(feature, pattern)
  if empty(matchlist)
    return has(a:feature)
  endif
  let [major, minor, patch] = matchlist[1:3]
  let l:version = major * 100 + minor
  return v:version != l:version
        \ ? v:version > l:version
        \ : has('patch-'.patch)
endfunction
