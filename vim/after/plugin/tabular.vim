" Only run this if function available
if !exists(':AddTabularPattern')
    finish
endif

" Shortcut patterns for Tabular; first colon, semicolon, comma, equals sign
AddTabularPattern! f: /^[^:]*\zs:/
AddTabularPattern! f; /^[^;]*\zs;/
AddTabularPattern! f, /^[^,]*\zs,/
AddTabularPattern! f= /^[^=]*\zs=/

