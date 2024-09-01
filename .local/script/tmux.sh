#!/usr/bin/env dash

. "${HOME}/.local/lib/util.sh"

__tmux_running() {
    pgrep \
        -u "$(id -u)" \
        -f "^tmux .*start" \
        >/dev/null
}

__tmux_start() {
    printf "tmux> launching...\n"
    tmux start-server
    "${HOME}/.config/tmux/script/task/sys.sh"
    "${HOME}/.config/tmux/script/task/dot.sh" --no-attach

    # so that there exists a history of attached sessions already
    tmux attach-session -t "=dot:=main" ";" attach-session -t "=sys:=mnt.3"
}

__tmux_attach_session() {
    if [ "${TMUX}" ]; then
        printf "tmux> already in tmux, done!\n"
        return
    fi

    local _session
    _session="$(tmux list-sessions -F "#{session_name}" | __fzf)"
    tmux attach-session -t "${_session}"
}

__tmux_attach_window() {
    local _session _window _choice
    _choice="$(
        tmux list-sessions -F "#{session_name}" | while read -r _session; do
            tmux list-windows -t "${_session}" -F "#{window_name}" | while read -r _window; do
                printf "%s> %s\n" "${_session}" "${_window}"
            done
        done |
            __fzf |
            sed "s/^\(.*\)> \(.*\)$/=\1:=\2/"
    )"

    if [ "${TMUX}" ]; then
        tmux switch-client -t "${_choice}"
        return
    fi

    # NOTE:
    #   equivalent to:
    #   $ tmux attach-session ";" switch-client -t "${_choice}"
    tmux attach-session -t "${_choice}"
}

case "${1}" in
    "run")
        if ! __tmux_running; then
            __tmux_start
            return
        fi
        __tmux_attach_window
        ;;
    *) ;;
esac
