# Person-specific settings
# (Define 'from', 'realname', and specify alternate addresses in here)
source ~/.mutt/muttrc.local

# Names
set use_domain   = yes
set use_from     = yes
set reverse_name = yes

# SMTP implementation
set sendmail = 'DOTFILES_SENDMAIL'

# Mailbox type and location
set mbox_type = 'Maildir'
set folder    = '~/Mail/'

# Submailboxes
set spoolfile = '+inbox'
set postponed = '+drafts'
set record    = '+sent'
mailboxes !

# Addresses
set query_command = 'abook --mutt-query %s'

# Alerts
set beep_new = yes

# Caching
set header_cache = '~/.cache/mutt/headers'

# Colors
color indicator black   white
color normal    default default
color status    white   color22
color tree      default default

# Completion
bind editor <Tab> complete-query
bind editor ^T    complete

# Files
set delete = yes
set move   = no

# Flags
set mark_old = no

# Headers
hdr_order Date From To Cc
set edit_headers = yes

# Index
set index_format = '%4C %Z %{%b %d %Y} %-15.15L (%?l?%4l&%4c?) %s'

# Interaction
set confirmappend = no
set wait_key      = no
set quit          = ask-yes

# Intervals
set mail_check = 5
set sleep_time = 0

# Mailboxes
set confirmcreate = yes

# Menus
set menu_context = 1

# Pager
set pager_context = 1
set pager_format  = '%4C %Z %[!%b %e at %I:%M %p]  %.20n  %s%* -- (%P)'
set pager_stop    = yes

# Presentation/formatting
set markers     = no
set smart_wrap  = yes
set text_flowed = yes
set tilde       = yes
alternative_order text/plain text/html *
auto_view text/html

# Responses
set fast_reply        = yes
set forward_format    = 'Fw: %s'
set include           = yes
set use_envelope_from = yes

# Searching/sorting
set sort            = 'threads'
set sort_aux        = 'last-date-received'
set strict_threads  = yes
set thorough_search = yes

# Encryption settings
set crypt_replysign          = yes
set crypt_replyencrypt       = yes
set crypt_replysignencrypted = yes
set crypt_use_gpgme          = yes
set crypt_verify_sig         = yes

# PGP settings
set pgp_auto_decode = yes

# Vim-ish bindings
bind index gg first-entry
bind index G  last-entry
bind pager gg top
bind pager G  bottom
bind index,pager \Cu half-up
bind index,pager \Cd half-down
bind generic,index,browser,pager \Cf next-page
bind generic,index,browser,pager \Cb previous-page

# Jump to mailboxes
macro generic,index,browser,pager gi '<change-folder>=inbox<enter>' 'Change to inbox folder'
macro generic,index,browser,pager gs '<change-folder>=sent<enter>' 'Change to sent folder'

# Blindly save message to whatever box is suggested
macro index,pager S 's<enter>' 'Save message blindly'

# Run gms to retrieve all mail
macro generic,index,browser,pager gm '!gms --quiet &<enter>' 'Run gms'

# Shortcut to add addresses to abook
macro index,pager A '<pipe-message>abook --add-email<enter>' 'Add sender address to abook'