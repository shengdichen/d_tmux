#   default-terminal terminal
#   Set the default terminal for new windows created in this session - the default
#   value of the TERM environment variable. For tmux to work correctly, this must
#   be set to ‘screen’, ‘tmux’ or a derivative of them.
#
# Set the $TERM variable according to recommandations in man-page, critical for
# correct color display and SSH forwarding.
# NOTE: Only applicable for newly created windows, existing windows will NOT be
# affected if changed post-creation. Also, any explicit setting of $TERM in
# shell rc-files WILL override this.
set-option -s default-terminal "tmux-256color"



#   escape-time time
#   Set the time in milliseconds for which tmux waits after an escape is input to
#   determine if it is part of a function or meta key sequences. The default is 500
#   milliseconds.
#
# set escape-time to 300 milliseconds in accordance to recommendations of neoVim
set-option -s escape-time 300



# exiting tmux-server {{{

#   exit-empty [on | off]
#   If enabled (the default), the server will exit when there are no active
#   sessions.
#
# prevent server from exiting even when no further sessions remain, thus
# requiring manually executing:
#       kill-server
# to terminate the tmux-server
#
# NOTE: Exiting the tmux-server will reset all statistics, e.g., the unique IDs of
# Sessions, Windows and Panes
set-option -s exit-empty off


#   exit-unattached [on | off]
#   If enabled, the server will exit when there are no attached clients.
#
# prevent server from exiting even when no further attached clients exist
set-option -s exit-unattached off

# }}}



# limits {{{

#   buffer-limit number
#   Set the number of buffers; as new buffers are added to the top of the stack,
#   old ones are removed from the bottom if necessary to maintain this maximum
#   length.
#


#   message-limit number
#   Set the number of error or information messages to save in the message log for
#   each client. The default is 100.
#

# }}}



#   command-alias[] name=value
#   This is an array of custom aliases for commands. If an unknown command matches
#   name, it is replaced with value. For example, after: set -s command-alias[100]
#   zoom='resize-pane -Z' Using:
#
#   zoom -t:.1 Is equivalent to:
#
#   resize-pane -Z -t:.1 Note that aliases are expanded when a command is parsed
#   rather than when it is executed, so binding an alias with bind-key will bind
#   the expanded form.
#
#       set-option -s command-alias[0] choose='choose-tree -ZN'
#



#   focus-events [on | off]
#   When enabled, focus events are requested from the terminal if supported and
#   passed through to applications running in tmux. Attached clients should be
#   detached and attached again after changing this option.
#



#   history-file path
#   If not empty, a file to which tmux will write command prompt history on exit
#   and load it from on start.
#



#   set-clipboard [on | external | off]
#   Attempt to set the terminal clipboard content using the xterm(1) escape
#   sequence, if there is an Ms entry in the terminfo(5) description (see the
#   TERMINFO EXTENSIONS section).  If set to on, tmux will both accept the escape
#   sequence to create a buffer and attempt to set the terminal clipboard. If set
#   to external, tmux will attempt to set the terminal clipboard but ignore
#   attempts by applications to set tmux buffers. If off, tmux will neither accept
#   the clipboard escape sequence nor attempt to set the clipboard.
#
#   Note that this feature needs to be enabled in xterm(1) by setting the resource:
#
#   disallowedWindowOps: 20,21,SetXprop
#
#   Or changing this property from the xterm(1) interactive menu when required.
#



#   terminal-overrides[] string
#   Allow terminal descriptions read using terminfo(5) to be overridden. Each entry
#   is a colon-separated string made up of a terminal type pattern (matched using
#   fnmatch(3)) and a set of name=value entries.  For example, to set the ‘clear’
#   terminfo(5) entry to ‘\e[H\e[2J’ for all terminal types matching ‘rxvt*’:
#
#   rxvt*:clear=\e[H\e[2J The terminal entry value is passed through strunvis(3)
#   before interpretation.
#
set-option -sgu terminal-override
set-option -sga terminal-overrides ',*:XT'
set-option -sga terminal-overrides ',*:Ms=\E]52;%p1%s;%p2%s\007'
set-option -sga terminal-overrides ',*:Cs=\E]12;%p1%s\007:Cr=\E]112\007'
set-option -sga terminal-overrides ',*:RGB:Tc'
set-option -sga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'


#   user-keys[] key
#   Set list of user-defined key escape sequences. Each item is associated with a
#   key named ‘User0’, ‘User1’, and so on.  For example:
#
#   set -s user-keys[0] "\e[5;30012~"
#   bind User0 resize-pane -L 3
#

