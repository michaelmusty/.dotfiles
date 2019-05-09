" Don't complete certain files that I'm not likely to want to manipulate from
" within Vim; this is kind of expensive to reload, so I've made it a plugin
" with a load guard
if &compatible || v:version < 700 || !has('wildignore')
  finish
endif
if exists('loaded_wildmenu')
  finish
endif
let loaded_wildmenu = 1

" Helper function for local scope
function! s:Wildignore() abort

  " New empty array
  let ignores = []

  " Archives
  let ignores += [
        \ '*.7z'
        \,'*.bz2'
        \,'*.gz'
        \,'*.jar'
        \,'*.rar'
        \,'*.tar'
        \,'*.xz'
        \,'*.zip'
        \ ]

  " Bytecode
  let ignores += [
        \ '*.class'
        \,'*.pyc'
        \ ]

  " Databases
  let ignores += [
        \ '*.db'
        \,'*.dbm'
        \,'*.sdbm'
        \,'*.sqlite'
        \ ]

  " Disk
  let ignores += [
        \ '*.adf'
        \,'*.bin'
        \,'*.hdf'
        \,'*.iso'
        \ ]

  " Documents
  let ignores += [
        \ '*.docx'
        \,'*.djvu'
        \,'*.odp'
        \,'*.ods'
        \,'*.odt'
        \,'*.pdf'
        \,'*.ppt'
        \,'*.xls'
        \,'*.xlsx'
        \ ]

  " Encrypted
  let ignores += [
        \ '*.asc'
        \,'*.gpg'
        \ ]

  " Executables
  let ignores += [
        \ '*.exe'
        \ ]

  " Fonts
  let ignores += [
        \ '*.ttf'
        \ ]

  " Images
  let ignores += [
        \ '*.bmp'
        \,'*.gd2'
        \,'*.gif'
        \,'*.ico'
        \,'*.jpeg'
        \,'*.jpg'
        \,'*.pbm'
        \,'*.png'
        \,'*.psd'
        \,'*.tga'
        \,'*.xbm'
        \,'*.xcf'
        \,'*.xpm'
        \ ]

  " Incomplete
  let ignores += [
        \ '*.filepart'
        \ ]

  " Objects
  let ignores += [
        \ '*.a'
        \,'*.o'
        \ ]

  " Sound
  let ignores += [
        \ '*.au'
        \,'*.aup'
        \,'*.flac'
        \,'*.mid'
        \,'*.m4a'
        \,'*.mp3'
        \,'*.ogg'
        \,'*.opus'
        \,'*.s3m'
        \,'*.wav'
        \ ]

  " System-specific
  let ignores += [
        \ '.DS_Store'
        \ ]

  " Translation
  let ignores += [
        \ '*.gmo'
        \ ]

  " Version control
  let ignores += [
        \ '.git'
        \,'.hg'
        \,'.svn'
        \ ]

  " Video
  let ignores += [
        \ '*.avi'
        \,'*.gifv'
        \,'*.mp4'
        \,'*.ogv'
        \,'*.rm'
        \,'*.swf'
        \,'*.webm'
        \ ]

  " Vim
  let ignores += [
        \ '*~'
        \,'*.swp'
        \ ]

  " If on a system where case matters for filenames, for any that had
  " lowercase letters, add their uppercase analogues
  if has('fname_case')
    for ignore in ignores
      if ignore =~# '\l'
        call add(ignores, toupper(ignore))
      endif
    endfor
  endif

  " Return the completed setting
  return join(ignores, ',')

endfunction

" Run helper function just defined
let &wildignore = s:Wildignore()
