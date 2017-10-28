# Watch a directory for changes and commit them with jfc(1d) if there are any;
# requires inotifywait(1)
self=jfcd

# Function wrapper around inotifywait(1)
inw() {
    inotifywait \
        @./.git \
        -e create -e delete -e modify -e move \
        --recursive \
        --syslog \
        . |
        logger --tag "$self"
}

# Directory to check is first and only argument; defaults to current directory
cd -- "${1:-.}" || exit

# Run a while loop over inotifywait(1) calls, running jfc(1d) on the working
# directory
while inw ; do jfc ; done
