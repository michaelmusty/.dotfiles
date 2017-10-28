for game in games/*.sh ; do
    sh -n "$game" || exit
done
printf 'All shell scripts in games parsed successfully.\n'
