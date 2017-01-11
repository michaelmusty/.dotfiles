# Some systems' /etc/profile setups export PS1, which really fouls things up
# when switching between non-login shells; let's put things right by unsetting
# it to break the export and then just setting them as simple variables
unset PS1 PS2 PS3 PS4
PS1='$ ' PS2='> ' PS3='? ' PS4='+ '
