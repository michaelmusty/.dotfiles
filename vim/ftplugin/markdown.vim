" Block system ftplugin from loading to avoid HTML ftplugin load
if exists('b:did_ftplugin') || &compatible
  finish
endif
let b:did_ftplugin = 1
