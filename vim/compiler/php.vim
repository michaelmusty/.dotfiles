" :compiler support for PHP syntax checking with `php -l`
if exists('current_compiler') || &compatible || !has('patch-7.4.191')
  finish
endif
let current_compiler = 'php'

CompilerSet makeprg=php\ -lq\ -f\ %:S
CompilerSet errorformat=
      \%E<b>%.%#Parse\ error</b>:
        \\ %m\ in\ <b>%f</b>\ on\ line\ <b>%l</b><br\ />,
      \%W<b>%.%#Notice</b>:
        \\ %m\ in\ <b>%f</b>\ on\ line\ <b>%l</b><br\ />,
      \%E%.%#Parse\ error:
        \\ %m\ in\ %f\ on\ line\ %l,
      \%W%.%#Notice:
        \\ %m\ in\ %f\ on\ line\ %l,
      \%-G%.%#
