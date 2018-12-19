# POSIX shell
for game in games/*.sh ; do
    sh -n -- "${game%.sh}" || exit
done
