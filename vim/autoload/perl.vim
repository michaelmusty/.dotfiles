" Version number specifier format
let g:perl#verpat = '\m\C^'
      \ . '\(our\s\+\$VERSION\s*=\D*\)'
      \ . '\(\d\+\)\.\(\d\+\)'
      \ . '\(.*\)'

" Version number bumper
function! perl#BumpVersion(major) abort
  let l:view = winsaveview()
  let l:li = search(g:perl#verpat)
  if !l:li
    echomsg 'No version number declaration found'
    return
  endif
  let l:matches = matchlist(getline(l:li), g:perl#verpat)
  let [l:lvalue, l:major, l:minor, l:rest]
        \ = matchlist(getline(l:li), g:perl#verpat)[1:4]
  if a:major
    let l:major = perl#Setf(l:major, l:major + 1)
    let l:minor = perl#Setf(l:minor, 0)
  else
    let l:minor = perl#Setf(l:minor, l:minor + 1)
  endif
  let l:version = l:major.'.'.l:minor
  call setline(l:li, l:lvalue.l:version.l:rest)
  if a:major
    echomsg 'Bumped major $VERSION: '.l:version
  else
    echomsg 'Bumped minor $VERSION: '.l:version
  endif
  call winrestview(l:view)
endfunction

" Explanatory wrappers
function! perl#BumpVersionMinor() abort
  call perl#BumpVersion(0)
endfunction
function! perl#BumpVersionMajor() abort
  call perl#BumpVersion(1)
endfunction

" Helper function to format a number without decreasing its digit count
function! perl#Setf(old, new) abort
  return repeat('0', strlen(a:old) - strlen(a:new)).a:new
endfunction
