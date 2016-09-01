# Total a column of integers
{ tot += $1 }
END { printf "%u\n", tot }
