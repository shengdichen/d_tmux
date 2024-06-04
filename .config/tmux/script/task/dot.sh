#!/usr/bin/env dash

SCRIPT_PATH="$(realpath "$(dirname "${0}")")"
cd "${SCRIPT_PATH}" || exit 3

. "./util.sh"
. "../util.sh"

SESSION="dot"

__base() {
    local _window="base"
    local _target="=${SESSION}:=${_window}"

    __create_window \
        --session "${SESSION}" \
        --pos "last" \
        --name "${_window}" \
        --allow-dup \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/" \
                --path-2 "${HOME}/.config/"
        )"
}

__prv() {
    local _window="prv"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/d_prv/" \
                --path-2 "${HOME}/.password-store/"
        )"
}

__wm() {
    local _window="wm"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/d_sway/" \
                --path-2 "${HOME}/.config/hypr/"
        )"

    __vifm_tab_set \
        --target "${_target}" \
        --new \
        --name "hypr" \
        --path-1 "${HOME}/dot/dot/d_sway/.config/hypr/" \
        --path-2 "${HOME}/dot/dot/d_sway/.config/fuzzel/"

    __vifm_tab_set \
        --target "${_target}" \
        --new \
        --name "sway" \
        --path-1 "${HOME}/dot/dot/d_sway/.config/sway/" \
        --path-2 "${HOME}/dot/dot/d_sway/.config/swaylock/"
}

__zsh() {
    local _window="zsh"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/d_zsh/" \
                --path-2 "${HOME}/.config/zsh/"
        )"

    local _pane="=${SESSION}:=${_window}.1"
    __vifm_tab_set \
        --target "${_pane}" \
        --new \
        --name "conf" \
        --path-1 "${HOME}/dot/dot/d_zsh/.config/zsh/conf/" \
        --path-2 "${HOME}/dot/dot/d_zsh/.config/"

    __vifm_tab_set \
        --target "${_pane}" \
        --new \
        --name "script" \
        --path-1 "${HOME}/dot/dot/d_zsh/.local/script/" \
        --path-2 "${HOME}/.local/script/"

    __vifm_tab_set \
        --target "${_pane}" \
        --new \
        --name "xdg" \
        --path-1 "${HOME}/dot/dot/d_zsh/.local/share/applications/" \
        --path-2 "${HOME}/.local/share/applications/"
}

__mpv() {
    local _window="mpv"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/d_mpv/" \
                --path-2 "${HOME}/.config/mpv/"
        )"

    __vifm_tab_set \
        --target "${_target}" \
        --new \
        --name "js" \
        --path-1 "${HOME}/dot/dot/d_mpv/js/src/js/lib" \
        --path-2 "${HOME}/dot/dot/d_mpv/js/src/"
}

__nvim() {
    local _window="nvim"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/d_nvim/" \
                --path-2 "${HOME}/.config/nvim/"
        )"

    __vifm_tab_set \
        --target "${_target}" \
        --new \
        --name "conf" \
        --path-1 "${HOME}/dot/dot/d_nvim/.config/nvim/conf/rpre/plugin/external" \
        --path-2 "${HOME}/dot/dot/d_nvim/.config/nvim/conf/rpre/pack/start/start/shrakula/lua/shrakula"
}

__tmux() {
    local _window="tmux"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/d_tmux/" \
                --path-2 "${HOME}/.config/tmux/"
        )"

    __vifm_tab_set \
        --target "${_target}" \
        --new \
        --name "script" \
        --path-1 "${HOME}/dot/dot/d_tmux/.config/tmux/script/" \
        --path-2 "${HOME}/dot/dot/d_prv/.config/tmux/script"
}

__vifm() {
    local _window="vifm"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/d_vifm/" \
                --path-2 "${HOME}/.config/vifm/"
        )"

    __vifm_tab_set \
        --target "${_target}" \
        --new \
        --name "conf" \
        --path-1 "${HOME}/dot/dot/d_vifm/.config/vifm/scripts/" \
        --path-2 "${HOME}/dot/dot/d_vifm/src/"
}

__mail() {
    local _window="mail"
    local _target="=${SESSION}:=${_window}"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --path-1 "${HOME}/dot/dot/d_mail/.local/share/mail/" \
                --path-2 "${HOME}/dot/dot/d_mail/.config/neomutt/"
        )"

    __new_pane \
        --target "${_target}.1" \
        --direction "horz" \
        --cmd "neomutt"

    __new_pane --target "${_target}.2"
    sleep 1 # HACK: wait for the new (shell-)pane to spawn fully
    __send_key --target "${_target}.3" -- "protonmail-bridge-core -n"

    __new_pane \
        --target "${_target}.3" \
        --cd "${HOME}/dot/dot/d_mail/.config/fdm" \
        --cmd "nvim -- ./config"
}

__main() {
    __create_session --name "${SESSION}"

    for _e in "base" "prv" "wm" "zsh" "mpv" "nvim" "tmux" "vifm" "mail"; do
        printf "%s\n" "${_e}"
    done | fzf --multi --reverse --height 37% | while read -r _line; do
        "__${_line}"
    done
    __attach_session "${SESSION}"
}
__main
