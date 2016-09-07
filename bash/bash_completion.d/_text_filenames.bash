# Exclude files by filesystem type and extension that likely aren't
# viewable/editable in plain text
#
# I've seen some very clever people figure out ways to actually read the files
# or run something like file(1) over them to make an educated guess as to
# whether they're binary or not, but I don't really want to go that far. It's
# not supposed to be perfect, just a bit more likely to complete singly with
# the thing I want, and I want it to stay fast.
#
_text_filenames() {
    while IFS= read -r item ; do

        # Exclude blanks
        [[ -n $item ]] || return

        # Exclude files with block, character, pipe, or socket type
        [[ ! -b $item ]] || return
        [[ ! -c $item ]] || return
        [[ ! -p $item ]] || return
        [[ ! -S $item ]] || return

        # Check the filename extension to know what to exclude
        case $item in

            # Binary image file formats
            *.bmp|*.gif|*.jpeg|*.jpg|*.png|*.xcf) ;;
            *.BMP|*.GIF|*.JPEG|*.JPG|*.PNG|*.XCF) ;;

            # Video file formats
            *.avi|*.gifv|*.mkv|*.mov|*.mpg|*.rm|*.webm) ;;
            *.AVI|*.gifv|*.MKV|*.MOV|*.MPG|*.RM|*.WEBM) ;;

            # Audio file formats
            *.au|*.aup|*.flac|*.mid|*.h2song|*.mp[34]|*.ogg|*.wav) ;;
            *.AU|*.AUP|*.FLAC|*.MID|*.H2SONG|*.MP[34]|*.OGG|*.WAV) ;;

            # Document formats
            *.cbr|*.doc|*.docx|*.odp|*.odt|*.pdf|*.xls|*.xlsx) ;;
            *.CBR|*.DOC|*.DOCX|*.ODP|*.ODT|*.PDF|*.XLS|*.XLSX) ;;

            # Compressed/archived file formats
            # (Yes I know Vim can read these)
            *.bz2|*.deb|*.gz|*.tar|*.xz|*.zip) ;;
            *.BZ2|*.DEB|*.GZ|*.TAR|*.XZ|*.ZIP) ;;

            # Known binary extensions
            # (I haven't included .com; on UNIX, that's more likely to be
            # something I saved from a website and named after the domain)
            *.a|*.dat|*.drv|*.exe|*.o) ;;
            *.A|*.DAT|*.DRV|*.EXE|*.O) ;;

            # Filesystems
            *.bin|*.cue|*.img|*.iso|*.raw) ;;
            *.BIN|*.CUE|*.IMG|*.ISO|*.RAW) ;;

            # Complete everything else; some of it will still be binary
            *) COMPREPLY[${#COMPREPLY[@]}]=$item ;;

        esac
    done < <(compgen -A file -- "${COMP_WORDS[COMP_CWORD]}")
}
