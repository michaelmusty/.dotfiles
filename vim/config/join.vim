" Don't join lines with two spaces at the end of sentences; I don't two-space,
" despite the noble Steve Losh's exhortations
set nojoinspaces

" Rebind normal J to run plugin-defined join that doesn't jump around, but
" only if we have the eval feature, because otherwise this mapping won't exist
" and we should keep the default behaviour
if has('eval')
  nmap J <Plug>FixedJoin
endif
