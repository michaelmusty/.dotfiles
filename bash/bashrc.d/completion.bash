# Various easy completions for Bash builtins; more specific stuff goes in
# ~/.bash_completion.d

# If COMP_WORDBREAKS has a value, strip all colons from it; this allows
# completing filenames correctly, since an unquoted colon is not a syntactic
# character: <http://tiswww.case.edu/php/chet/bash/FAQ> (E13)
[[ -n $COMP_WORDBREAKS ]] && COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

# Aliases
complete -A alias unalias

# Bash builtins
complete -A builtin builtin
complete -A enabled disable
complete -A disabled enable

# Bash options
complete -A setopt set

# Commands
complete -A command alias command complete compopt coproc exec if hash time type until while

# Directories
complete -A directory cd pushd mkdir rmdir

# Functions and variables
complete -A function function
complete -A function -A variable declare export local readonly typeset unset
complete -A variable for getopts let read select

# Help topics
complete -A helptopic help

# Jobspecs
complete -P '%' -A job disown fg jobs
complete -P '%' -A stopped bg

# Readline bindings
complete -A binding bind

# Shell options
complete -A shopt shopt

# Signal names
complete -A signal trap

# The `mapfile` builtin in Bash >= 4.0
((BASH_VERSINFO[0] >= 4)) && complete -A arrayvar mapfile readarray

# If we have dynamic completion loading (Bash>=4.0), use it
if ((BASH_VERSINFO[0] >= 4)) ; then

    # Handler tries to load appropriate completion for commands
    _completion_loader() {
        [[ -n $1 ]] || return
        local compspec
        compspec=$HOME/.bash_completion.d/$1.bash
        [[ -f $compspec ]] || return
        source "$compspec" >/dev/null 2>&1 && return 124
    }
    complete -D -F _completion_loader -o bashdefault -o default

# If not, load all of the completions up now
else
    for sh in "$HOME"/.bash_completion.d/*.bash ; do
        [[ -e $sh ]] && source "$sh"
    done
    unset -v sh
fi
