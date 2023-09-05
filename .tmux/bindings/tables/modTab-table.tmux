# client {{{
# misc:
#   detach-client
#   choose-client
#   refresh-client
#   suspend-client
# }}}

# session {{{
bind-key -T modTab M-Tab switch-client -l  # last-active session

bind-key -T modTab M-( switch-client -p  # previous session
bind-key -T modTab M-) switch-client -n  # next session

bind-key -T modTab M-s choose-tree -Zs -O "time"
# }}}

# window {{{
# NOTE:
#   -a: create after current window
#   -n: name window by prompt-input, with |void| as default
#   3.  launch vifm to the default directories
bind-key -T modTab M-S-Enter {
    command-prompt -I "void" \
        "new-window -a -n %1 \"vifm ~/xdg ~/mnt\"";
}

# navigation {{{
bind-key -T modTab M-w choose-tree -NZ -O "time"  # choose window interactively

bind-key -T modTab M-` select-window -t ":{last}."  # last-active window

bind-key -T modTab M-n select-window -t ":{next}."
bind-key -T modTab M-p select-window -t ":{previous}."

# 1-0 {{{
bind-key -T modTab M-1 select-window -t ":=1."
bind-key -T modTab M-2 select-window -t ":=2."
bind-key -T modTab M-3 select-window -t ":=3."

# 4-7 {{{
# NOTE:
#   4 := current-2
#   5 := current-3
#   6 := current+3
#   7 := current+2
bind-key -T modTab M-4 { \
    run-shell -b "zsh \
    ~/.tmux/bindings/tables/modtab_scripts/navigation/window.zsh current +2";
}

bind-key -T modTab M-5 { \
    run-shell -b "zsh \
    ~/.tmux/bindings/tables/modtab_scripts/navigation/window.zsh current +3";
}

bind-key -T modTab M-6 { \
    run-shell -b "zsh \
    ~/.tmux/bindings/tables/modtab_scripts/navigation/window.zsh current -3";
}

bind-key -T modTab M-7 { \
    run-shell -b "zsh \
    ~/.tmux/bindings/tables/modtab_scripts/navigation/window.zsh current -2";
}
# }}}

# 8-0 {{{
# NOTE:
#   0 := end
#   9 := end-1
#   8 := end-2
bind-key -T modTab M-0 { \
    run-shell -b "zsh \
    ~/.tmux/bindings/tables/modtab_scripts/navigation/window.zsh end 0";
}

bind-key -T modTab M-9 { \
    run-shell -b "zsh \
    ~/.tmux/bindings/tables/modtab_scripts/navigation/window.zsh end 1";
}

bind-key -T modTab M-8 { \
    run-shell -b "zsh \
    ~/.tmux/bindings/tables/modtab_scripts/navigation/window.zsh end 2";
}
# }}}
# }}}

# misc:
#   command-prompt "find-window -Z -- '%%'"
# }}}

bind-key -T modTab M-C-q {
    confirm-before -p "Close window?" kill-window;
}

# displacement {{{
# inner-session displacement
bind-key -T modTab M-N swap-window -d -t ":{next}."
bind-key -T modTab M-P swap-window -d -t ":{previous}."

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
bind-key -T modTab M-Enter {
    command-prompt \
        -p "Exec:" \
        "split-window %1";
}

bind-key -T modTab M-";" select-pane -Z -t ":.{last}"

# NOTE:
#   -Z := maintain zoom-level
bind-key -r -T modTab M-k select-pane -Z -U
bind-key -r -T modTab M-j select-pane -Z -D
bind-key -r -T modTab M-h select-pane -Z -L
bind-key -r -T modTab M-l select-pane -Z -R

# toggle fullscreen (zoom-level)
bind-key -T modTab M-z resize-pane -Z

# resize {{{
bind-key -r -T modTab M-Up resize-pane -U
bind-key -r -T modTab M-Down resize-pane -D
bind-key -r -T modTab M-Left resize-pane -L
bind-key -r -T modTab M-Right resize-pane -R

# NOTE:
#   -y := vertical stretch
bind-key -T modTab M-PPage resize-pane -y "50%"
bind-key -T modTab M-NPage resize-pane -y "100%"

bind-key -T modTab M-Home {
    swap-pane -d -t ":.2";
    resize-pane -y "67%";
}
bind-key -T modTab M-End {
    swap-pane -d -t ":.2";
    resize-pane -y "100%";
}
# }}}

# displacement {{{
# -d to stay on the current pane after swapping
bind-key -T modTab M-H swap-pane -d -t ":.{left-of}"
bind-key -T modTab M-K swap-pane -d -t ":.{up-of}"
bind-key -T modTab M-J swap-pane -d -t ":.{down-of}"
bind-key -T modTab M-L swap-pane -d -t ":.{right-of}"

# break pane into a new window after the current one
bind-key -T modTab M-! {
    command-prompt \
        -p "Break to new window:" \
        -I "#{window_name}_" \
        "break-pane -a -n %1";
}

# select (mark) pane
bind-key -T modTab M-m select-pane -m

# paste pane
bind-key -T modTab M-M {
    move-pane -t ":.";
    select-layout main-vertical;
}
# }}}

bind-key -T modTab M-q {
    confirm-before -p "Close pane?" kill-pane;
}
bind-key -T modTab M-Q {
    respawn-pane -k;
}
# }}}

# buffer {{{
bind-key -T modTab M-[ copy-mode
bind-key -T modTab M-] paste-buffer  # use most-recent buffer

bind-key -T modTab M-= choose-buffer
# }}}

# misc {{{
bind-key -T modTab M-: command-prompt

bind-key -T modTab M-e {
    source-file "~/.tmux.conf";
    display-message "Config reloaded";
}
bind-key -T modTab M-E {
    source-file "~/.tmux/modes/focus.tmux";
    display-message "Focus-mode";
}

bind-key -T modTab M-F1 list-keys  # list binds (of all tables)
# }}}

# vim: filetype=tmux foldmethod=marker
