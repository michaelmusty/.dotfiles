# Convert UNIX line endings to DOS ones
!/\r$/ { $0 = $0 "\r" }
{ print }
