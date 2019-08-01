# Escape a dangerous URL to discourage it from being made into a link
s|^http|hxxp|
s|://|[&]|
s|\.|[&]|g
