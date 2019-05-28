" :compiler support for Perl::Critic
" <https://metacpan.org/pod/Perl::Critic>
if exists('current_compiler') || &compatible || v:version < 800
  finish
endif
let current_compiler = 'perlcritic'

CompilerSet makeprg=perlcritic\ --verbose\ 1\ --\ %:S
CompilerSet errorformat=%f:%l:%c:%m
