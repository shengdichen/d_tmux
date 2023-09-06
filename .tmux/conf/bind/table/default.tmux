# NOTE:
#   1. -a
#   unset all binds of the key-table
#   2.  -q
#   fail silently: suppress warning when starting server, as these non-default
#   key-tables do not yet exist
unbind-key -a -q -T default

# client {{{
# misc:
#   detach-client
#   choose-client
#   refresh-client
#   suspend-client
# }}}

# session {{{
bind-key -T default M-Tab switch-client -l  # last-active session

bind-key -T default M-( switch-client -p  # previous session
bind-key -T default M-) switch-client -n  # next session

bind-key -T default M-s choose-tree -Zs -O "time"
# }}}

# window {{{
# NOTE:
#   -a: create after current window
#   -n: name window by prompt-input, with |void| as default
#   3.  launch vifm to the default directories
bind-key -T default M-S-Enter {
    command-prompt -I "void" \
        "new-window -a -n %1 \"vifm ~/xdg ~/mnt\"";
}

# navigation {{{
bind-key -T default M-w choose-tree -NZ -O "time"  # choose window interactively

bind-key -T default M-` select-window -t ":{last}."  # last-active window

bind-key -T default M-n select-window -t ":{next}."
bind-key -T default M-p select-window -t ":{previous}."

# 1-0 {{{
bind-key -T default M-1 select-window -t ":=1."
bind-key -T default M-2 select-window -t ":=2."
bind-key -T default M-3 select-window -t ":=3."

# 4-7 {{{
# NOTE:
#   4 := current-2
#   5 := current-3
#   6 := current+3
#   7 := current+2
bind-key -T default M-4 { \
    run-shell -b "zsh \
    ~/.tmux/script/window.zsh current +2";
}

bind-key -T default M-5 { \
    run-shell -b "zsh \
    ~/.tmux/script/window.zsh current +3";
}

bind-key -T default M-6 { \
    run-shell -b "zsh \
    ~/.tmux/script/window.zsh current -3";
}

bind-key -T default M-7 { \
    run-shell -b "zsh \
    ~/.tmux/script/window.zsh current -2";
}
# }}}

# 8-0 {{{
# NOTE:
#   0 := end
#   9 := end-1
#   8 := end-2
bind-key -T default M-0 { \
    run-shell -b "zsh \
    ~/.tmux/script/window.zsh end 0";
}

bind-key -T default M-9 { \
    run-shell -b "zsh \
    ~/.tmux/script/window.zsh end 1";
}

bind-key -T default M-8 { \
    run-shell -b "zsh \
    ~/.tmux/script/window.zsh end 2";
}
# }}}
# }}}

# misc:
#   command-prompt "find-window -Z -- '%%'"
# }}}

bind-key -T default M-C-q {
    confirm-before -p "Close window?" kill-window;
}

# displacement {{{
# inner-session displacement
bind-key -T default M-N swap-window -d -t ":{next}."
bind-key -T default M-P swap-window -d -t ":{previous}."

# available commands:
#   1. moving
#   a. command-prompt "move-window -t '%%'"
#   -> prompt for index for moving current window
#   b. move-window -t <my_session>:<window_number>
#   -> cross-session displacement
#
#   2. linking: (cpp-like) references of windows
#   a. link-window -t <my_session>:
#   b. unlink-window -t <my_session>:<my_window>
# }}}
# }}}

# pane {{{
bind-key -T default M-Enter {
    command-prompt \
        -p "Exec:" \
        "split-window %1";
}

# NOTE:
#   -Z := maintain zoom-level
bind-key -r -T default M-k select-pane -Z -U
bind-key -r -T default M-j select-pane -Z -D
bind-key -r -T default M-h select-pane -Z -L
bind-key -r -T default M-l select-pane -Z -R

# resize {{{
# toggle fullscreen (zoom-level)
bind-key -T default M-z resize-pane -Z

bind-key -r -T default M-Up resize-pane -U
bind-key -r -T default M-Down resize-pane -D
bind-key -r -T default M-Left resize-pane -L
bind-key -r -T default M-Right resize-pane -R

# NOTE:
#   -y := vertical stretch
bind-key -T default M-PPage resize-pane -y "50%"
bind-key -T default M-NPage resize-pane -y "100%"

bind-key -T default M-Home {
    swap-pane -d -t ":.2";
    resize-pane -y "67%";
}
bind-key -T default M-End {
    swap-pane -d -t ":.2";
    resize-pane -y "100%";
}
# }}}

# displacement {{{
# -d := stay on the current pane after swapping
bind-key -T default M-H swap-pane -d -t ":.{left-of}"
bind-key -T default M-K swap-pane -d -t ":.{up-of}"
bind-key -T default M-J swap-pane -d -t ":.{down-of}"
bind-key -T default M-L swap-pane -d -t ":.{right-of}"

# break pane into a new window after the current one
bind-key -T default M-! {
    command-prompt \
        -p "Break to new window:" \
        -I "#{window_name}_" \
        "break-pane -a -n %1";
}

# select (mark) pane
bind-key -T default M-m select-pane -m

# paste pane
bind-key -T default M-M {
    move-pane -t ":.";
    select-layout main-vertical;
}
# }}}

bind-key -T default M-q {
    confirm-before -p "Close pane?" \
        kill-pane;
}
bind-key -T default M-Q {
    respawn-pane -k;
}
# }}}

# buffer {{{
bind-key -T default M-[ copy-mode
bind-key -T default M-] paste-buffer  # use most-recent buffer

bind-key -T default M-= choose-buffer
# }}}

# misc {{{
bind-key -T default M-: command-prompt
bind-key -T default M-";" {
    command-prompt -p "$SHELL:" "run-shell \"%%\"";
}

bind-key -T default M-e {
    source-file "~/.tmux.conf";
    display-message "Config reloaded";
}
bind-key -T default M-E {
    source-file "~/.tmux/script/mode/focus.tmux"
    display-message "Focus-mode";
}

bind-key -T default M-F1 list-keys  # list binds (of all tables)
# }}}

# vim: filetype=tmux foldmethod=marker
