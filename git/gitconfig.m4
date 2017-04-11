[advice]
    statusHints = false
    detachedHead = false
    implicitIdentity = false
    pushUpdateRejected = false

[alias]
    amend = commit --amend
    ls = log --oneline
    others = ls-files --others --exclude-standard
    fuckit = "!git clean -dfx ; git reset --hard"

[color]
    ui = true

[commit]
    status = false

[core]
    compression = 9

[diff]
    algorithm = patience
    tool = vimdiff

[difftool]
    prompt = false

[fetch]
    output = compact
    prune = true

[grep]
    extendRegexp = true
    lineNumber = true

[log]
    date = local
    decorate = short

[merge]
    ff = false

[pager]
    diff = cat

[pull]
    ff = only

[push]
    default = current

[sendemail]
    confirm = compose
    smtpServer = DF_SENDMAIL

[status]
    short = true
    showUntrackedFiles = all

[user]
    name = DF_NAME
    email = DF_EMAIL
    signingKey = DF_KEY
