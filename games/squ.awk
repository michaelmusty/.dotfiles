# Make a reduced Latin square out of each line of input
len = length {
    str = toupper($0)
    split("", let, ":")
    for (i = 1; i <= len; i++)
        let[i - 1] = substr(str, i, 1)
    for (j in let)
        for (k in let)
            printf (k + 1 < len) ? "%s " : "%s\n", let[(k + j) % len]
}
