# Total a list of numbers
BEGIN { tot = 0 }
{ tot += $1 }
END { print tot }
