# Skip duplicate lines (without requiring sorted input)
$0 in seen { next }
length($0) {
    seen[$0] = 1
    print
}
