find bin -type f -name '*.sh' -print -exec shellcheck -e SC1090 -s sh -- {} +
