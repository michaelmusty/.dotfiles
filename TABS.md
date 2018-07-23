Spaces to tabs
==============

If you prefer tabs to spaces, the following recipe seems to convert everything
pretty nicely:

    $ find . -name .git -prune -o -name vim -prune -o -type f \
        -exec sh -c \
        'for f;do unexpand -t4 "$f">"$f".tmp;mv "$f" "$f".tmp;done' \
        _ {} +

    $ find vim -name bundle -prune -o -type f \
        -exec sh -c \
        'for f;do unexpand -t2 "$f">"$f".tmp;mv "$f" "$f".tmp;done' \
        _ {} +

If you have GNU unexpand(1) and can add `--first-only` to each of those calls,
the results seem perfect.

You can configure Vim to accommodate this by removing the settings in
vim/config/indent.vim for:

* `expandtab`
* `shiftround`
* `shiftwidth`
* `smarttab`
* `softtabstop`
