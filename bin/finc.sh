# Count the number of entries from a find(1) condition
find "${@:-.}" -exec printf '%.sx' {} + | wc -c
