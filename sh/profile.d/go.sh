# Define path for Go code to be installed
GOPATH=$HOME/.local/gocode
export GOPATH

# Prepend GOPATH to PATH for the executables if it exists
[ -d "$GOPATH"/bin ] && PATH=$GOPATH/bin:$PATH
