# Convenience script for posting to ix.io pastebin
cat -- "${@:--}" |
curl -F 'f:1=<-' http://ix.io/
