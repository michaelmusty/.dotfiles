" Don't assume a number with a leading zero is octal; it's far more likely a
" zero-padded decimal, so increment and decrement with ^A and ^X on that basis
set nrformats-=octal
