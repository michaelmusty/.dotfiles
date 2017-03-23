# Strip out a lot of machine and X11 dependent crap from the initial
# environment
set-environment -gru COLORFGBG
set-environment -gru COLORTERM
set-environment -gru DISPLAY
set-environment -gru SSH_CLIENT
set-environment -gru SSH_CONNECTION
set-environment -gru SSH_TTY
set-environment -gru WINDOWID

# Otherwise, use the environment we had when we started; don't touch it during
# a session unless I specifically ask
set-option -g update-environment ''

# Setting this makes each new pane a non-login shell, which suits me better
set-option -g default-command "$SHELL"

# Expect a 256-color terminal
set-option -g default-terminal 'screen-256color'

# Change the prefix to ^A rather than the default of ^B, because I'm a godless
# GNU Screen refugee, and also I like using ^B in my shell and in Vim more
unbind-key C-b
set-option -g prefix C-a
bind-key a send-prefix

# Repeating the prefix switches to the last window and back, a GNU Screen
# feature that's hardwired into my brain now
bind-key C-a last-window

# Quick ways to kill single windows and the whole server
bind-key '/' confirm-before 'kill-window'
bind-key '\' confirm-before 'kill-server'

# Slightly more intuitive way to split windows
bind-key '_' split-window -v
bind-key '|' split-window -h

# Switch to the last active pane
bind-key Tab last-pane

# Use the vi mode for tmux interaction behaviour in copy and choice modes
set-window-option -g mode-keys vi

# Detach with Alt-M, no prefix required
bind-key -n M-m detach

# Vim-like pane resizing
bind-key -r '+' resize-pane -U 5
bind-key -r '-' resize-pane -D 5
bind-key -r '<' resize-pane -L 5
bind-key -r '>' resize-pane -R 5

# Vim-like pane switching
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

# Vim-like keys for visual mode and yanking therefrom
bind-key -t vi-copy 'v' begin-selection
bind-key -t vi-copy 'y' copy-selection
bind-key -t vi-copy Escape cancel

# Join and break panes
bind-key J choose-window "join-pane -h -s '%%'"
bind-key B break-pane -d

# Select only sessions in the choose-tree menu, not the whole tree of sessions
# and windows, I prefer to drill down
bind-key s choose-session

# Session title on the left side of the status bar
set-option -g status-left '[#S] '

# Username, hostname, and the current date on the right side of the status bar
set-option -g status-right ' [#(whoami)@#H] #(date +"%F %T")'

# Update the status bar every second
set-option -g status-interval 1

# The first window in a session has index 1, rather than 0
set-option -g base-index 1

# Don't worry about timeouts for key combinations, as I don't use Escape as
# meta and prefer things to be snappier
set-option -g escape-time 0

# Keep plenty of history
set-option -g history-limit 100000

# Don't interfere with my system clipboard
set-option -g set-clipboard off

# Only force individual windows to the smallest attached terminal size, not
# whole sessions
set-window-option -g aggressive-resize on

# If I don't set a title on a window, use the program name for the window title
set-window-option -g automatic-rename on

# However, don't let terminal escape sequences rename my windows
set-window-option -g allow-rename off

# Window titles are the window index, a colon, the window or command name, and
# any activity or alert indicators
set-window-option -g window-status-format "#I:#W#F"

# Message dialogs are white on blue
set-option -g message-style "bg=colour18,fg=colour231"

# Window choosers are white on blue
set-window-option -g mode-style "bg=colour18,fg=colour231"

# Pane borders are always in the background color
set-option -g pane-border-style "fg=DF_TMUX_BG"
set-option -g pane-active-border-style "fg=DF_TMUX_BG"

# Inactive windows have slightly washed-out system colours
set-option -g window-style "bg=colour232,fg=colour248"
set-option -g window-active-style "bg=colour0,fg=colour15"

# The status bar has the defined background and foreground colours
set-option -g status-style "bg=DF_TMUX_BG,fg=DF_TMUX_FG"

# Titles of windows default to black text with no embellishment
set-window-option -g window-status-style "fg=colour16"

# The title of the active window is in white rather than black
set-window-option -g window-status-current-style "fg=colour231"

# A window with a bell has a title with a red background until cleared
set-window-option -g window-status-bell-style "bg=colour9"
