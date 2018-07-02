" Revert settings that Debian might have touched
if $VIM ==# '/usr/share/vim' && filereadable('/etc/debian_version')

  " Set options back to appropriate defaults
  set history&
  set suffixes&
  if has('cmdline_info')
    set ruler&
  endif
  if has('printoptions')
    set printoptions&
  endif

  " Restore terminal settings to reflect terminfo
  set t_Co& t_Sf& t_Sb&

  " Remove addons directories from 'runtimepath' if present
  silent! set runtimepath-=/var/lib/vim/addons
  silent! set runtimepath-=/var/lib/vim/addons/after

endif
