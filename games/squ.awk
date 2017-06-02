# Make a reduced Latin square out of each line of input
l = length($0) {
    str = toupper($0)
    for (j = 0; j < l; j++)
        for (k = 0; k < l; k++)
            printf (k < l - 1) ? "%s " : "%s\n", substr(str, (k + j) % l + 1, 1)
}
