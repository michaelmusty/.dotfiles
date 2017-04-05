find ksh \
    -type f -name '*.sh' -exec shellcheck -e SC1090 -s sh -- {} + -o \
    -type f -exec shellcheck -e SC1090 -s ksh -- {} +
