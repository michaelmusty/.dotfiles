find X -type f \( -name xinitrc -o -name '*.sh' \) -print -exec shellcheck -e SC1090 -s sh -- {} +
