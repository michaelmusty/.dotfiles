" Set mail message as an alternative filetype
if !exists('b:alternate_filetypes')
  let b:alternate_filetypes = [&filetype, 'mail']
endif

" Stop here if the user doesn't want ftplugin mappings
if exists('no_plugin_maps') || exists('no_textarea_maps')
  finish
endif

" #s expands to the #signature tag used in Cerb
inoreabbrev #s #signature
