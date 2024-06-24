#!/usr/bin/env dash

SCRIPT_PATH="$(realpath "$(dirname "${0}")")"
cd "${SCRIPT_PATH}" || exit 3

. "./util.sh"
. "../util.sh"

SESSION="sys"

__setup() {
    local _window="setup"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                "${HOME}/dot/setup" \
                "${HOME}/.config/tmux/script"
        )"
}

__mnt() {
    local _window="mnt"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                "${HOME}/mnt/" \
                "/run/media"
        )"

    __new_pane \
        --target "${_target}.1" \
        --direction "horz" \
        --cmd "${SCRIPT_PATH}/cmd.sh --top"

    __new_pane \
        --target "${_target}.2" \
        --cmd "${SCRIPT_PATH}/cmd.sh --time"
}

__mda() {
    local _window="mda"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                "$(xdg-user-dir MUSIC)" \
                "$(xdg-user-dir VIDEOS)"
        )"

    __new_pane \
        --target "${_target}.1" \
        --direction "horz" \
        --cmd "${SCRIPT_PATH}/cmd.sh --pulse"

    __new_pane \
        --target "${_target}.2" \
        --cmd "${SCRIPT_PATH}/cmd.sh"
}

__attach_session "${SESSION}"
__setup
__mnt
__mda
