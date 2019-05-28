" :compiler support for Perl::Critic
" <https://metacpan.org/pod/Perl::Critic>
if exists('current_compiler') || &compatible || !has('patch-7.4.191')
  finish
endif
let current_compiler = 'perlcritic'

CompilerSet makeprg=perlcritic\ --verbose\ 1\ --\ %:S
CompilerSet errorformat=%f:%l:%c:%m
