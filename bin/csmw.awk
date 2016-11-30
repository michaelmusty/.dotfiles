# Print an English comma-separated list of monospace-quoted words (backticks)
{
    for (i = 1; i <= NF; i++)
        ws[++wc] = $i
}
END {
    if (wc > 2)
        for (i = 1; i <= wc; i++)
            printf (i < wc) ? "`%s`, " : "and `%s`\n", ws[i]
    else if (wc == 2)
        printf "`%s` and `%s`\n", ws[1], ws[2]
    else if (wc == 1)
        printf "`%s`\n", ws[1]
}
