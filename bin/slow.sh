# Convert uppercase letters in a stream to lowercase
cat "${@:--}" |
tr '[:upper:]' '[:lower:]'
