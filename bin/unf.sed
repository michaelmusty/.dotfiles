# Unfold lines with leading spaces (e.g. RFC 822 headers)
/^[ \t]/!{
  1!{
    x
    p
    x
  }
  h
}
/^[ \t]/{
  H
  x
  s/[\r\n]//g
  x
}
$!d
x
