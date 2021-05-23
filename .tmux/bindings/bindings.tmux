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


# non-default key-tables {{{
#   NOTE:
#       to remove all legacy bindings of a non-default key-table from previous
#       experimentations:
#       1.  -a
#           ->  unbind all of the key-table
#       2.  -q
#           ->  fail silently to suppress warning when starting server
#           initially, as the non-default key-table did not exist prior to
#           server-launch
#

# |defTab| key-table {{{

# set the default key-table to the customized key-table with less awkward
# prefixing
#       set-option -g key-table defTab

# remove all legacy bindings of the key-table |defTab| that might persist from
# previous experimentations
#       unbind-key -a -q -T defTab

# }}}


# |modTab| key-table {{{

# set the default key-table to the customized key-table with less awkward
# prefixing
set-option -g key-table modTab

unbind-key -a -q -T modTab

# }}}
# }}}

# }}}



# bindings {{{

source-file ~/.tmux/bindings/tables/prefix-table.tmux

source-file ~/.tmux/bindings/tables/defTab-table.tmux

source-file ~/.tmux/bindings/tables/modTab-table.tmux

# }}}

