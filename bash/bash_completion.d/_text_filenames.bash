# Exclude files by filesystem type and extension that likely aren't
# viewable/editable in plain text
#
# I've seen some very clever people figure out ways to actually read the files
# or run something like file(1) over them to make an educated guess as to
# whether they're binary or not, but I don't really want to go that far.  It's
# not supposed to be perfect, just a bit more likely to complete singly with
# the thing I want, and I want it to stay fast.
#
_text_filenames() {

    # Iterate through completions produced by subshell
    local ci comp
    while IFS= read -r comp ; do

        # Exclude blanks
        [[ -n $comp ]] || continue

        # Exclude nonexistent (some sort of error)
        [[ -e $comp ]] || continue

        # Exclude files with block, character, pipe, or socket type
        ! [[ -b $comp ]] || continue
        ! [[ -c $comp ]] || continue
        ! [[ -p $comp ]] || continue
        ! [[ -S $comp ]] || continue

        # Accept directories
        if [[ -d $comp ]] ; then
            COMPREPLY[ci++]=$comp
            continue
        fi

        # Check the filename extension to know what to exclude
        (
            # Case-insensitive matching available since 3.1-alpha
            shopt -s nocasematch 2>/dev/null

            # Match against known binary patterns
            case $comp in

                # Archives
                (*.7z) ;;
                (*.bz2) ;;
                (*.gz) ;;
                (*.jar) ;;
                (*.rar) ;;
                (*.tar) ;;
                (*.xz) ;;
                (*.zip) ;;

                # Bytecode
                (*.class) ;;
                (*.pyc) ;;

                # Databases
                (*.db) ;;
                (*.dbm) ;;
                (*.sdbm) ;;
                (*.sqlite) ;;

                # Disk
                (*.adf) ;;
                (*.bin) ;;
                (*.hdf) ;;
                (*.iso) ;;

                # Documents
                (*.docx) ;;
                (*.djvu) ;;
                (*.odp) ;;
                (*.ods) ;;
                (*.odt) ;;
                (*.pdf) ;;
                (*.ppt) ;;
                (*.xls) ;;
                (*.xlsx) ;;

                # Encrypted
                (*.asc) ;;
                (*.gpg) ;;

                # Executables
                (*.exe) ;;

                # Fonts
                (*.ttf) ;;

                # Images
                (*.bmp) ;;
                (*.gd2) ;;
                (*.gif) ;;
                (*.ico) ;;
                (*.jpeg) ;;
                (*.jpg) ;;
                (*.pbm) ;;
                (*.png) ;;
                (*.psd) ;;
                (*.tga) ;;
                (*.xbm) ;;
                (*.xcf) ;;
                (*.xpm) ;;

                # Incomplete
                (*.filepart) ;;

                # Objects
                (*.a) ;;
                (*.o) ;;

                # Sound
                (*.au) ;;
                (*.aup) ;;
                (*.flac) ;;
                (*.mid) ;;
                (*.m4a) ;;
                (*.mp3) ;;
                (*.ogg) ;;
                (*.opus) ;;
                (*.s3m) ;;
                (*.wav) ;;

                # System-specific
                (.DS_Store) ;;

                # Translation
                (*.gmo) ;;

                # Version control
                (.git) ;;
                (.hg) ;;
                (.svn) ;;

                # Video
                (*.avi) ;;
                (*.gifv) ;;
                (*.mp4) ;;
                (*.ogv) ;;
                (*.rm) ;;
                (*.swf) ;;
                (*.webm) ;;

                # Vim
                (*~) ;;
                (*.swp) ;;

                # Not binary that we can tell; maybe editable
                (*) exit 0 ;;

            esac

            # Known usually-binary extension; flag failure
            exit 1

        ) || continue

        # Complete everything else; some of it will still be binary
        COMPREPLY[ci++]=$comp

    done < <(compgen -A file -- "$2")
}
