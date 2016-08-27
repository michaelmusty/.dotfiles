# Completion setup for Make, completing targets
_make() {

    # Bail if no legible Makefile
    [[ -r Makefile ]] || return 1

    # Iterate through the Makefile, line by line
    while IFS= read -r line ; do
        case $line in

            # We're looking for targets but not variable assignments
            $'\t'*) ;;
            *:=*) ;;
            *:*)

                # Break the target up with space delimiters
                local -a targets
                IFS=' ' read -rd '' -a targets < \
                    <(printf '%s\0' "${line%%:*}")

                # Iterate through the targets and add suitable ones
                local target
                for target in "${targets[@]}" ; do
                    case $target in

                        # Don't complete special targets beginning with a
                        # period
                        .*) ;;

                        # Don't complete targets with names that have
                        # characters outside of the POSIX spec (plus slashes)
                        *[^[:word:]./-]*) ;;

                        # Add targets that match what we're completing
                        ${COMP_WORDS[COMP_CWORD]}*)
                            COMPREPLY[${#COMPREPLY[@]}]=$target
                            ;;
                    esac
                done
                ;;
        esac
    done < Makefile
}
complete -F _make -o default make
