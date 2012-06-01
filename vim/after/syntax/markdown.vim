"
" Fix list definitions until I have time to figure out how to stop them
" applying to within code blocks and can suggest it to the maintainer.
"
syn clear markdownListMarker
syn match markdownListMarker "[-*+]\%(\s\+\S\)\@=" contained
syn clear markdownOrderedListMarker
syn match markdownOrderedListMarker "\<\d\+\.\%(\s*\S\)\@=" contained

