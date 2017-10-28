# Always use bytewise sorting if not already set
[ -z "$LC_COLLATE" ] || return
LC_COLLATE=C
export LC_COLLATE
