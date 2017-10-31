# POSIX sh
for game in games/*.sh ; do
    sh -n -- "${game%.sh}" || exit
done
printf 'sh(1) games parsed successfully.\n'
