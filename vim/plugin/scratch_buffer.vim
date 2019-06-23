command! -bar -count=0 -nargs=* ScratchBuffer
      \ call scratch_buffer#(<q-mods>, <q-count>, <f-args>)
