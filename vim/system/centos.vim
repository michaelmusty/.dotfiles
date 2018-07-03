" Revert settings that CentOS might have touched
if $VIM !=# '/usr/share/vim' || !filereadable('/etc/centos-release')
  finish
endif

" Set options back to appropriate defaults
set history&
if has('cmdline_info')
  set ruler&
endif
if has('cscope')
  set csprg& cst& csto& csverb&
  silent! cs kill
endif
if has('gui')
  set guicursor&
endif
if has('viminfo')
  set viminfo&
endif

" Restore terminal settings to reflect terminfo
set t_Co& t_Sf& t_Sb&

" Delete autocmd groups
augroup redhat
  autocmd!
augroup END
augroup! redhat
