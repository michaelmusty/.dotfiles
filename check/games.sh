# POSIX sh
for game in games/*.sh ; do
    sh -n -- "${game%.sh}" || exit
done
printf 'POSIX sh games parsed successfully.\n'
