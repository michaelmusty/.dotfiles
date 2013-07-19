# Use a unified format for diff by default
alias diff='diff -u'

# Add a colon prompt to ed when a command is expected rather than text; makes
# it feel a lot more like using ex
alias ed='ed -p:'

# Don't print the GDB copyright message on every invocation
alias gdb='gdb -q'

# Refuse to do highly destructive things in the MySQL client; prevents me from
# updating or deleting rows without a WHERE clause, among other things
alias mysql='mysql --safe-updates'

