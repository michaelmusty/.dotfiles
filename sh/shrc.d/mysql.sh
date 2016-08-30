# If a file ~/.mysql/$1.cnf exists, call mysql(1) using that file, discarding
# the rest of the arguments. Otherwise just run MySQL with given args. Use
# restrictive permissions on these files. Doesn't allow filenames beginning
# with hyphens.
#
# Examples:
#
#   [client]
#   host=dbhost.example.com
#   user=foo
#   password=SsJ2pICe226jM
#
#   [mysql]
#   database=bar
#
mysql() {
    case $1 in
        -*) ;;
        *)
            [ -f "$HOME/.mysql/$1".cnf ] &&
                set -- --defaults-extra-file="$HOME/.mysql/$1".cnf
            ;;
    esac
    command mysql "$@"
}
