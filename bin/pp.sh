# Print the full path to each argument; path need not exist
for arg ; do
    case $arg in
        /*) path=$arg ;;
        *) path=$PWD/$arg ;;
    esac
    printf '%s\n' "$path"
done
