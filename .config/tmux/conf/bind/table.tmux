# NOTE {{{
# 1. common flags for |choose-tree|
#   -N: hide preview
#   -Z: display in full-screen (ignore pane-size)
#   -G: expand session-group(s)
#   -s/w: expand to session(s)/window(s)
# }}}

# NOTE:
#   1. -a
#   unset all binds of the key-table
#   2. -q
#   fail silently: suppress warning when starting server, as non-default
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
bind-key -T default M-Tab {
    switch-client -l;  # last-active session
}

bind-key -T default M-s {
    choose-tree -s -G -NZ -O "time";
}

bind-key -T default M-C-q {
    confirm-before \
        -p "Close session?" \
        "kill-session; switch-client -t =sys:.";
}

bind-key -T default M-C {
    command-prompt \
        -p "Duplicate session:","Duplicate name:" \
        -I "#{session_name}","#{session_name}_" \
        {
            new-session -t "%1";
            rename-session "%2";
        };
}
# }}}

# window {{{
# NOTE:
#   -a: create after current window
#   -n: name window by prompt-input, with |void| as default
bind-key -T default M-S-Enter {
    command-prompt \
        -I "void" \
        "new-window -a -n %1 \"vifm ~/xdg ~/mnt\"";
}

# navigation {{{
bind-key -T default M-S {
    # -w: expand to window(s)
    choose-tree -w -Z -O "time";  # choose window interactively
}

bind-key -T default M-` {
    select-window -t ":{last}.";  # last-active window
}

bind-key -T default M-n {
    select-window -t ":{next}.";
}
bind-key -T default M-p {
    select-window -t ":{previous}.";
}

# 1-0 {{{
bind-key -T default M-1 {
    select-window -t ":=1.";
}
bind-key -T default M-2 {
    select-window -t ":=2.";
}
bind-key -T default M-3 {
    select-window -t ":=3.";
}

# 4-7 {{{
# NOTE:
#   4 := current-2
#   5 := current-3
#   6 := current+3
#   7 := current+2
bind-key -T default M-4 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/window.zsh current +2";
}

bind-key -T default M-5 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/window.zsh current +3";
}

bind-key -T default M-6 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/window.zsh current -3";
}

bind-key -T default M-7 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/window.zsh current -2";
}
# }}}

# 8-0 {{{
# NOTE:
#   0 := end
#   9 := end-1
#   8 := end-2
bind-key -T default M-0 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/window.zsh end 0";
}

bind-key -T default M-9 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/window.zsh end 1";
}

bind-key -T default M-8 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/window.zsh end 2";
}
# }}}
# }}}

# misc:
#   command-prompt "find-window -Z -- '%%'"
# }}}

# displacement {{{
# inner-session displacement
bind-key -T default M-N {
    swap-window -d -t ":{next}.";
}
bind-key -T default M-P {
    swap-window -d -t ":{previous}.";
}

bind-key -T default M-! {
    # move to first
    move-window -b -t ":^.";
}
bind-key -T default M-) {
    # move to last
    move-window -a -t ":$.";
}

bind-key -T default M-Q {
    confirm-before -p "Close window?" {
        unlink-window -k;
    };
}

# copy (duplicate)
bind-key -T default M-c {
    display-message "Duplicate window";
    choose-tree -s -NZ -O "time" {
        link-window -a -t "%%";
    };
}

# cross-session displacement
bind-key -T default M-x {
    display-message "Move window";
    choose-tree -s -NZ -O "time" {
        # -a := insert after target (here, selected from choose-tree)
        move-window -a -t "%%";
    };
}
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
bind-key -r -T default M-k {
    select-pane -Z -U;
}
bind-key -r -T default M-j {
    select-pane -Z -D;
}
bind-key -r -T default M-h {
    select-pane -Z -L;
}
bind-key -r -T default M-l {
    select-pane -Z -R;
}

# resize {{{
# toggle fullscreen (zoom-level)
bind-key -T default M-z {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/layout.sh vifm_miller";
    resize-pane -Z;
}

bind-key -r -T default M-Up {
    resize-pane -U "1";
}
bind-key -r -T default M-S-Up {
    resize-pane -U "7";
}
bind-key -r -T default M-Down {
    resize-pane -D "1";
}
bind-key -r -T default M-S-Down {
    resize-pane -D "7";
}
bind-key -r -T default M-Left {
    resize-pane -L "1";
}
bind-key -r -T default M-S-Left {
    resize-pane -L "7";
}
bind-key -r -T default M-Right {
    resize-pane -R "1";
}
bind-key -r -T default M-S-Right {
    resize-pane -R "7";
}

bind-key -T default M-S-C-Up {
    resize-pane -y "1";
}
bind-key -r -T default M-S-C-Down {
    resize-pane -y "100%";
}
bind-key -r -T default M-S-C-Left {
    resize-pane -x "1";
}
bind-key -r -T default M-S-C-Right {
    resize-pane -x "100%";
}

# NOTE:
#   -y := vertical stretch
bind-key -T default M-PPage {
    resize-pane -y "50%";
}
bind-key -T default M-NPage {
    resize-pane -y "100%";
}

bind-key -T default M-Home {
    resize-pane -y "67%";
}
bind-key -T default M-End {
    resize-pane -y "100%";
}
# }}}

# displacement {{{
# -d := stay on the current pane after swapping
bind-key -T default M-H {
    swap-pane -d -t ":.{left-of}";
}
bind-key -T default M-K {
    swap-pane -d -t ":.{up-of}";
}
bind-key -T default M-J {
    swap-pane -d -t ":.{down-of}";
}
bind-key -T default M-L {
    swap-pane -d -t ":.{right-of}";
}

# break pane into a new window after the current one
bind-key -T default M-b {
    command-prompt \
        -p "Break to new window:" \
        -I "#{window_name}_" \
        "break-pane -a -n %1";
}

# select (mark) pane
bind-key -T default M-m {
    select-pane -m;
}

# paste pane
bind-key -T default M-M {
    move-pane -t ":.";
}

# split current pane and move (marked) pane there
bind-key -T default M-[ {
    join-pane -v -t ":.";  # vertically
}
bind-key -T default M-] {
    join-pane -h -t ":.";  # horizontally
}
# }}}

bind-key -T default M-q {
    confirm-before -p "Close pane?" {
        kill-pane;
    };
}
bind-key -T default M-Z {
    respawn-pane -k;
}
# }}}

# layout {{{
unbind-key -T prefix M-2
bind-key -T prefix M-2 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/layout.sh vert_even";
}
unbind-key -T prefix M-4
bind-key -T prefix M-4 {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/layout.sh vert_main";
}

unbind-key -T prefix M-BSpace
bind-key -T default M-BSpace {
    run-shell -b "${SHELL} \
    ~/.config/tmux/script/open.sh";
}
# }}}

# buffer (visual-mode) {{{
bind-key -T default M-v {
    # do NOT auto |begin-selection|
    copy-mode;
}
unbind-key -T copy-mode-vi v
bind-key -T copy-mode-vi v {
    send-keys -X "begin-selection";
}
bind-key -T copy-mode-vi V {
    display-message "V-Line";
    send-keys -X "select-line";
}
bind-key -T copy-mode-vi C-V {
    display-message "V-Block";
    send-keys -X "begin-selection";
    send-keys -X "rectangle-toggle";
}

bind-key -T copy-mode-vi K {
    send-key -N 4 "k";
}
bind-key -T copy-mode-vi J {
    send-key -N 4 "j";
}

bind-key -T copy-mode-vi y {
    send-keys -X "copy-pipe-and-cancel";
}
unbind-key -T copy-mode-vi Enter
bind-key -T default M-u {
    paste-buffer;  # use most-recent buffer
}

unbind-key -T copy-mode-vi C-C
bind-key -T copy-mode-vi C-C {
    send-keys -X "clear-selection";
}
unbind-key -T copy-mode-vi q
bind-key -T copy-mode-vi Q {
    send-keys -X "cancel";
}
# }}}

# misc {{{
bind-key -T default M-: {
    command-prompt;
}
bind-key -T default M-";" {
    command-prompt \
        -p "${SHELL}:" \
        "run-shell \"%%\"";
}

bind-key -T default M-e {
    source-file "~/.config/tmux/tmux.conf";
    display-message "Config reloaded";
}
bind-key -T default M-E {
    source-file "~/.config/tmux/script/mode/less.tmux";
    display-message "Less";
}
bind-key -T default M-C-e {
    source-file "~/.config/tmux/script/mode/more.tmux";
    display-message "More";
}

bind-key -T default M-F1 {
    list-keys;  # list binds (of all tables)
}
# }}}

# vim: filetype=tmux foldmethod=marker
