# setup {{{

# |prefix| key-table {{{

# C-b         Send the prefix key (C-b) through to the application.
# the key-binding to use to actually send the prefix, setting it to the prefix
# key itself equates to having to pressing the prefix twice to actually send it
# to the current application
bind-key    -T prefix       C-b                   send-prefix

# send the second prefix by pressing the same binding of |prefix2|
bind-key    -T prefix       M-Space               send-prefix -2

# }}}


# |defTab| key-table {{{

# set the default key-table to the customized key-table with less awkward
# prefixing
#       set-option -g key-table defTab

# remove all legacy bindings of the key-table |defTab| that might persist from
# previous experimentations
#       unbind-key -a -T defTab

# }}}


# |modTab| key-table {{{

# set the default key-table to the customized key-table with less awkward
# prefixing
set-option -g key-table modTab

# remove all legacy bindings of the key-table |defTab| that might persist from
# previous experimentations
unbind-key -a -T modTab

# }}}

# }}}



# bindings {{{

source-file ./prefix-table.tmux

source-file ./defTab-table.tmux

source-file ./modTab-table.tmux

# }}}

