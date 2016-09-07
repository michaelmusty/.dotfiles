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
            *.bmp|*.gif|*.ico|*.jpeg|*.jpg|*.png|*.tif|*.xcf) ;;
            *.BMP|*.GIF|*.ICO|*.JPEG|*.JPG|*.PNG|*.TIF|*.XCF) ;;

            # Font files
            *.ttf) ;;
            *.TTF) ;;

            # Video file formats
            *.avi|*.gifv|*.mkv|*.mov|*.mpg|*.rm|*.webm) ;;
            *.AVI|*.gifv|*.MKV|*.MOV|*.MPG|*.RM|*.WEBM) ;;

            # Lossy audio file formats
            *.au|*.mp[34]|*.ogg|*.snd|*.wma) ;;
            *.AU|*.MP[34]|*.OGG|*.SND|*.WMA) ;;

            # Lossless/source audio file formats
            *.aup|*.flac|*.mid|*.h2song|*.nwc|*.s3m|*.wav) ;;
            *.AUP|*.FLAC|*.MID|*.H2SONG|*.NWC|*.S3M|*.WAV) ;;

            # Document formats
            *.cbr|*.doc|*.docx|*.epub|*.odp|*.odt|*.pdf|*.xls|*.xlsx) ;;
            *.CBR|*.DOC|*.DOCX|*.EPUB|*.ODP|*.ODT|*.PDF|*.XLS|*.XLSX) ;;

            # Index file formats
            *.idx) ;;
            *.IDX) ;;

            # Compressed/archived file formats
            # (Yes I know Vim can read these)
            *.bz2|*.cab|*.deb|*.gz|*.lzm|*.pack|*.tar|*.xz|*.zip) ;;
            *.BZ2|*.CAB|*.DEB|*.GZ|*.LZM|*.PACK|*.TAR|*.XZ|*.ZIP) ;;

            # Filesystems/disk images
            *.bin|*.cue|*.hdf|*.img|*.iso|*.mdf|*.raw) ;;
            *.BIN|*.CUE|*.HDF|*.IMG|*.ISO|*.MDF|*.RAW) ;;

            # Other known binary extensions
            # (I haven't included .com; on UNIX, that's more likely to be
            # something I saved from a website and named after the domain)
            *.a|*.dat|*.drv|*.exe|*.o|*.torrent|*.wad|*.rom) ;;
            *.A|*.DAT|*.DRV|*.EXE|*.O|*.TORRENT|*.WAD|*.ROM) ;;

            # Complete everything else; some of it will still be binary
            *) COMPREPLY[${#COMPREPLY[@]}]=$item ;;

        esac
    done < <(compgen -A file -- "${COMP_WORDS[COMP_CWORD]}")
}
