# Define path for Go code to be installed
GOPATH=$HOME/.local/gocode
export GOPATH

# Prepend GOPATH to PATH for the executables if it exists
if [ -d "$GOPATH"/bin ] ; then
    PATH=$GOPATH/bin:$PATH
fi

