# Run sudoedit(8) with an appropriate user on a set of files

# Blank out the user variable
user=

# Iterate over the given files
for file do

    # Get the file's owner, or bail
    file_owner=$(stat -c %U -- "$file") || exit

    # Check that this file has the same owner as all previously checked files,
    # if any
    case $user in
        "$file_owner"|'')
            user=$file_owner
            ;;
        *)
            printf >&2 'sue: Files do not share a common owner\n'
            exit 1
            ;;
    esac
done

# Run sudoedit(8) as the user that owns all the files
sudoedit -u "$user" -- "$@"
