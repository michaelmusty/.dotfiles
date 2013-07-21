# Don't warn me about new mail all the time
shopt -u mailwarn &>/dev/null

# Autocorrect fudged paths in cd calls
shopt -s cdspell &>/dev/null

# Update the hash table properly
shopt -s checkhash &>/dev/null

# Warn me about stopped jobs when exiting
shopt -s checkjobs &>/dev/null

# Update columns and rows if window size changes
shopt -s checkwinsize &>/dev/null

# Put multi-line commands onto one line of history
shopt -s cmdhist &>/dev/null

# Expand globbing and variables for directory completion
shopt -s direxpand &>/dev/null

# Autocorrect fudged paths during completion
shopt -s dirspell &>/dev/null

# Include dotfiles in pattern matching
shopt -s dotglob &>/dev/null

# Enable advanced pattern matching
shopt -s extglob &>/dev/null

# Enable double-starring paths
shopt -s globstar &>/dev/null

# Append rather than overwrite Bash history
shopt -s histappend &>/dev/null

# Ignore me if I try to complete an empty line
shopt -s no_empty_cmd_completion &>/dev/null

