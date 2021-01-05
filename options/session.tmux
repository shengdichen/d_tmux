# beginning and end {{{

#   default-shell path
#   Specify the default shell. This is used as the login shell for new windows
#   when the default-command option is set to empty, and must be the full path
#   of the executable. When started tmux tries to set a default value from the
#   first suitable of the SHELL environment variable, the shell returned by
#   getpwuid(3), or /bin/sh. This option should be configured when tmux is used
#   as a login shell.
#
# full path of the default shell when creating new windows of the session,
# provided that the following |default-command| is left empty
#       set-option -g default-shell /bin/bash
set-option -g default-shell /bin/zsh

#   default-command shell-command
#   Set the command used for new windows (if not specified when the window is
#   created) to shell-command, which may be any sh(1) command. The default is
#   an empty string, which instructs tmux to create a login shell using the
#   value of the default-shell option.
#
# use the default (empty string, i.e., no-op) as shell command when creating
# new windows, which will create a new login shell by calling the shell
# specified by the |default-shell| option specified above
set-option -g default-command ''
# optionally, execute the shell command <some_shell_command> after invoking an
# instance of the shell, e.g., run |vi| on |bash|,
#     | set-option -g default-command '/bin/bash -c vi'



#   base-index index
#   Set the base index from which an unused index should be searched when a new
#   window is created. The default is zero.
#
# use 1-indexing whenever a new window is created
set-option -g base-index 1

#   renumber-windows [on | off]
#   If on, when a window is closed in a session, automatically renumber the other
#   windows in numerical order. This respects the base-index option if it has been
#   set. If off, do not renumber the windows.
#
# automatically renumber the remaining window(s) in numerical order with
# respect to the |base-index| set above whenever a window has been closed
set-option -g renumber-windows on



#   destroy-unattached [on | off]
#   If enabled and the session is no longer attached to any clients, it is
#   destroyed.
#
# do NOT destroy unattached sessions automatically, i.e., keep sessions alive
# that are not currently displayed on any client
set-option -g destroy-unattached off

#   detach-on-destroy [on | off]
#   If on (the default), the client is detached when the session it is attached to
#   is destroyed. If off, the client is switched to the most recently active of the
#   remaining sessions.
#
# do NOT detach the client if the attached session is destroyed, instead,
# switch to the remaining, last used session
set-option -g detach-on-destroy off

# }}}


# notification behavior {{{

#   activity-action [any | none | current | other]
#   Set action on window activity when monitor-activity is on. any means activity
#   in any window linked to a session causes a bell or message (depending on
#   visual-activity) in the current window of that session, none means all activity
#   is ignored (equivalent to monitor-activity being off), current means only
#   activity in windows other than the current window are ignored and other means
#   activity in the current window is ignored but not those in other windows.
#

#   bell-action [any | none | current | other]
#   Set action on a bell in a window when monitor-bell is on. The values are the
#   same as those for activity-action.
#

#   silence-action [any | none | current | other]
#   Set action on window silence when monitor-silence is on. The values are the
#   same as those for activity-action.
#

# determine on which windows events of <acitivty | bell | silence> nature will
# trigger a response from tmux, where the response itself is specified later
# with the visual-* options:
#
#   none:       on none of the windows
#   current:    only on currently active window
#   other:      on all other window(s) except the current one
#.  any:        on any window
#
# note that setting |*-action| to |none| is equivalent to setting |monitor-*|
# to |off|
set-option -g activity-action other
set-option -g bell-action any
set-option -g silence-action none



#   visual-activity [on | off | both]
#   If on, display a message instead of sending a bell when activity occurs in a
#   window for which the monitor-activity window option is enabled. If set to both,
#   a bell and a message are produced.
#

#   visual-bell [on | off | both]
#   If on, a message is shown on a bell in a window for which the monitor-bell
#   window option is enabled instead of it being passed through to the terminal
#   (which normally makes a sound). If set to both, a bell and a message are
#   produced. Also see the bell-action option.
#

#   visual-silence [on | off | both]
#   If monitor-silence is enabled, prints a message after the interval has expired
#   on a given window instead of sending a bell. If set to both, a bell and a
#   message are produced.
#

# the behavior of tmux when handling the event triggered in accordance to the
# setting of from |*-action| specified above
#   on:         display message on status-line
#   off:        flash screen by sending a bell
#   both:       dispaly message on statue-line AND flash screen by sending a
#               bell

set-option -g visual-activity on

# set the |off| to send a bell; adaquate, as a bell itself would trigger this,
# which will thus be forwarded by tmux
set-option -g visual-bell off

# throw-away setting, since |silence| is not monitored anyway
set-option -g visual-silence on

# }}}


# control input {{{

#   key-table key-table
#   Set the default key table to key-table instead of root.
#
#       set-option -g key-table root



#   mouse [on | off]
#   If on, tmux captures the mouse and allows mouse events to be bound as key
#   bindings. See the MOUSE SUPPORT section for details.
#
# disable mouse control (clickable windows, panes, resizable panes)
set-option -g mouse off



#   prefix key
#   Set the key accepted as a prefix key. In addition to the standard keys
#   described under KEY BINDINGS, prefix can be set to the special key ‘None’ to
#   set no prefix.
#
#   prefix2 key
#   Set a secondary key accepted as a prefix key. Like prefix, prefix2 can be set
#   to ‘None’.
#
# the key-binding to press in ANY key-table to enter the key-table |prefix|
# set an alternate prefix to 'alt+space'
set-option -g prefix C-b
set-option -g prefix2 M-Space



#   repeat-time time
#   Allow multiple commands to be entered without pressing the prefix-key again in
#   the specified time milliseconds (the default is 500). Whether a key repeats may
#   be set when it is bound using the -r flag to bind-key. Repeat is enabled for
#   the default keys bound to the resize-pane command.
#
set-option -g repeat-time 500

# }}}


# display customization {{{

#   display-panes-active-colour colour
#   Set the colour used by the display-panes command to show the indicator for the
#   active pane.
#
#   display-panes-colour colour
#   Set the colour used by the display-panes command to show the indicators for
#   inactive panes.
#
#   display-panes-time time
#   Set the time in milliseconds for which the indicators shown by the
#   display-panes command appear.
#
# display numbering for all visible panes of the current window, triggered with
# the tmux-command:
#       :display-panes
set-option -g display-panes-active-colour colour253
set-option -g display-panes-colour colour243
set-option -g display-panes-time 750



#   message-command-style style
#   Set status line message command style. For how to specify style, see the STYLES
#   section.
#
set-option -g message-command-style '\
bold italics \
fg=colour009 bg=colour255 \
'

#   message-style style
#   Set status line message style. For how to specify style, see the STYLES
#   section.
#
# format for inputting commands, displaying messages, etc. on the statusline
set-option -g message-style '\
bold italics \
fg=colour255 bg=colour016 \
'

# }}}



#   history-limit lines
#   Set the maximum number of lines held in window history. This setting applies
#   only to new windows - existing window histories are not resized and retain the
#   limit at the point they were created.
#
set-option -g history-limit 10000

#   display-time time
#   Set the amount of time for which status line messages and other on-screen
#   indicators are displayed. If set to 0, messages and indicators are displayed
#   until a key is pressed. time is in milliseconds.
#
set-option -g display-time 0

#   status-keys [vi | emacs]
#   Use vi or emacs-style key bindings in the status line, for example at the
#   command prompt. The default is emacs, unless the VISUAL or EDITOR environment
#   variables are set and contain the string ‘vi’.
#
set-option -g status-keys vi



#   assume-paste-time milliseconds
#   If keys are entered faster than one in milliseconds, they are assumed to
#   have been pasted rather than typed and tmux key bindings are not processed.
#   The default is one millisecond and zero disables.
#



#   default-size XxY
#   Set the default size of new windows when the window-size option is set to
#   manual or when a session is created with new-session -d. The value is the
#   width and height separated by an ‘x’ character. The default is 80x24.
#



#   lock-after-time number
#   Lock the session (like the lock-session command) after number seconds of
#   inactivity. The default is not to lock (set to 0).
#

#   lock-command shell-command
#   Command to run when locking each client. The default is to run lock(1) with
#   -np.
#



#   set-titles [on | off]
#   Attempt to set the client terminal title using the tsl and fsl terminfo(5)
#   entries if they exist. tmux automatically sets these to the \e]0;...\007
#   sequence if the terminal appears to be xterm(1). This option is off by default.
#
#   set-titles-string string
#   String used to set the client terminal title if set-titles is on. Formats are
#   expanded, see the FORMATS section.
#



#   update-environment[] variable
#   Set list of environment variables to be copied into the session environment
#   when a new session is created or an existing session is attached. Any variables
#   that do not exist in the source environment are set to be removed from the
#   session environment (as if -r was given to the set-environment command).
#



#   word-separators string
#   Sets the session's conception of what characters are considered word
#   separators, for the purposes of the next and previous word commands in copy
#   mode. The default is ‘ -_@’.
#
