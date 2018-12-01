# Simple completions for Bash builtins and POSIX utilities; more specific or
# complex stuff goes in ~/.bash_completion.d, for possible dynamic loading

# If COMP_WORDBREAKS has a value, strip all colons from it; this allows
# completing filenames correctly, since a colon is not a shell metacharacter:
# <http://tiswww.case.edu/php/chet/bash/FAQ> (E13)
if [[ -n $COMP_WORDBREAKS ]] ; then
    COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
fi

# If ~/.hosts exists, use that as the host completion file rather than
# /etc/hosts, so I can populate the list myself
if [[ -f $HOME/.hosts ]] ; then
    HOSTFILE=$HOME/.hosts
fi

# Aliases
complete -A alias \
    'unalias'

# Bash builtins
complete -A builtin \
    'builtin'
complete -A enabled \
    'disable'
complete -A disabled \
    'enable'

# Bash options
complete -A setopt \
    'set'

# Commands
complete -A command \
    'alias' \
    'command' \
    'complete' \
    'compopt' \
    'coproc' \
    'do' \
    'exec' \
    'if' \
    'hash' \
    'then' \
    'time' \
    'type' \
    'until' \
    'while'

# Directories
complete -A directory \
    'cd' \
    'pushd' \
    'mkdir' \
    'rmdir'

# Functions and variables
complete -A function \
    'function'
complete -A function -A variable \
    'declare' \
    'export' \
    'local' \
    'readonly' \
    'typeset' \
    'unset'
complete -A variable \
    'for' \
    'getopts' \
    'let' \
    'read' \
    'select'

# Help topics
complete -A helptopic \
    'help'

# Jobspecs
complete -P '%' -A job \
    'disown' \
    'fg' \
    'jobs' \
    'kill'
complete -P '%' -A stopped \
    'bg'

# Readline bindings
complete -A binding \
    'bind'

# Shell options
complete -A shopt \
    'shopt'

# Signal names
complete -A signal \
    'trap'

# The `mapfile` builtin in Bash >= 4.0
if ((BASH_VERSINFO[0] >= 4)) ; then
    complete -A arrayvar \
        'mapfile' \
        'readarray'
fi

# If we have dynamic completion loading (Bash >= 4.0), use it
if ((BASH_VERSINFO[0] >= 4)) ; then

    # Handler tries to load appropriate completion for commands
    _completion_loader() {

        # Check completed command for validity
        case $1 in
            # Not empty
            '') return 1 ;;
            # Not starting with an underscore
            _*) return 1 ;;
        esac

        # Build expected path for the command completion
        local compspec
        compspec=$HOME/.bash_completion.d/$1.bash

        # Skip directories and nonexistent files
        [[ -e $compspec ]] || return
        ! [[ -d $compspec ]] || return

        # Try to read the file, return 124 if it worked
        if source "$compspec" ; then
            return 124
        fi
    }

    # Set completion loader to use the above function
    complete -D -F _completion_loader -o bashdefault -o default

# If not, load all of the completions up now
else
    for bash in "$HOME"/.bash_completion.d/[^_]*.bash ; do
        [[ -e $bash ]] || continue
        source "$bash"
    done
    unset -v bash
fi
