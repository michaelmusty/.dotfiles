# Crude approach to get alphabetic words one per line from input, not sorted or
# deduplicated
BEGIN {
    FS = "(--|['_-]*[^[:alnum:]'_-]+['_-]*)"
}
{
    for (i = 1; i <= NF; i++)
        if ($i ~ /[a-zA-Z]/)
            print $i
}
