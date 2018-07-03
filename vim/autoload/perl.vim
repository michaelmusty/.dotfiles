" Quick-and-dirty version number bumper
function! perl#BumpVersion(major) abort
  let l:view = winsaveview()
  let l:search = @/
  let l:li = search('\C^our \$VERSION\s*=')
  if !l:li
    echomsg 'No version number declaration found'
    return
  endif
  if a:major
    silent execute "normal! /[0-9]\<CR>\<C-A>"
    echomsg 'Major version bumped: '.getline('.')
  else
    silent execute "normal! $?[0-9]\<CR>\<C-A>"
    echomsg 'Minor version bumped: '.getline('.')
  endif
  let @/ = l:search
  call winrestview(l:view)
endfunction

" Explanatory wrappers
function! perl#BumpVersionMinor() abort
  call perl#BumpVersion(0)
endfunction

function! perl#BumpVersionMajor() abort
  call perl#BumpVersion(1)
endfunction
