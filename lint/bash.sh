shellcheck -e SC1090 -s bash -- \
    bash/bash_completion \
    bash/bash_completion.d/*.bash \
    bash/bash_logout \
    bash/bash_profile \
    bash/bashrc \
    bash/bashrc.d/*.bash
