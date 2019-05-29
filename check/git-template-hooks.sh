for sh in git/template/hooks/*.sh ; do
    sh -n "${sh%.sh}" || exit
done
