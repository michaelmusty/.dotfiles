" Highlight TLSA and SSHFP records correctly
" <https://github.com/vim/vim/issues/220>
syn keyword zoneRRType
      \ contained TLSA SSHFP
      \ nextgroup=zoneRData skipwhite
