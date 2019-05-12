" Revert settings that Debian might have touched
if $VIM !=# '/usr/share/vim'
      \ || !filereadable('/etc/debian_version')
  finish
endif

" Set options back to appropriate defaults
set history&
set printoptions&
set ruler&
set suffixes&

" Restore terminal settings to reflect terminfo
set t_Co& t_Sf& t_Sb&

" Remove addons directories from 'runtimepath' if present
set runtimepath-=/var/lib/vim/addons
set runtimepath-=/var/lib/vim/addons/after
