# Print the first non-glob "Host" name from each line of ssh_config(5) files

# Manage the processing flag (starts set in each file)
FNR == 1 || /### sls/ { sls = 1 }
/### nosls/ { sls = 0 }

# If processing flag set, directive is "Host", and hostname has no wildcards,
# then print it
sls && $1 == "Host" && $2 !~ /\*/ { print $2 }
