#!/usr/bin/env dash

SCRIPT_PATH="$(realpath "$(dirname "${0}")")"
cd "${SCRIPT_PATH}" || exit 3

. "./util.sh"
. "../util.sh"

SESSION="dot"

__base() {
    __create_session \
        --name "${SESSION}" \
        --cmd "$(
            __make_cmd_vifm \
                "${HOME}/dot/dot" \
                "${HOME}/.config/tmux/script/task"
        )"
}

__setup() {
    local _window="setup"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                "${HOME}/dot/setup/post" \
                "${HOME}/dot/setup/extra"
        )"
}

__common() {
    local _window="common"

    __create_window \
        --session "${SESSION}" \
        --pos "last" \
        --name "${_window}" \
        --allow-dup \
        --cmd "$(
            __make_cmd_vifm \
                "${HOME}/dot/dot/" \
                "${HOME}/.config/"
        )"
}

__prv() {
    local _window="prv"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                "${HOME}/dot/dot/d_prv/" \
                "${HOME}/.password-store/"
        )"
}

__wm() {
    local _window="wm"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --tab --name "main" \
                "${HOME}/dot/dot/d_sway/" \
                "${HOME}/.config/hypr/" \
                \
                --tab --name "hypr" \
                "${HOME}/dot/dot/d_sway/.config/hypr/" \
                "${HOME}/dot/dot/d_sway/.config/fuzzel/" \
                \
                --tab --name "sway" \
                "${HOME}/dot/dot/d_sway/.config/sway/" \
                "${HOME}/dot/dot/d_sway/.config/swaylock/"
        )"
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
                --tab --name "main" \
                "${HOME}/dot/dot/d_zsh/" \
                "${HOME}/.config/zsh/" \
                \
                --tab --name "conf" \
                "${HOME}/dot/dot/d_zsh/.config/zsh/conf/" \
                "${HOME}/dot/dot/d_zsh/.config/" \
                \
                --tab --name "script" \
                "${HOME}/dot/dot/d_zsh/.local/script/" \
                "${HOME}/.local/script/" \
                \
                --tab --name "xdg" \
                "${HOME}/dot/dot/d_zsh/.local/share/applications/" \
                "${HOME}/.local/share/applications/"
        )"
}

__mpv() {
    local _window="mpv"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --tab --name "main" \
                "${HOME}/dot/dot/d_mpv/" \
                "${HOME}/.config/mpv/" \
                \
                --tab --name "js" \
                "${HOME}/dot/dot/d_mpv/js/src/js/lib" \
                "${HOME}/dot/dot/d_mpv/js/src/"
        )"
}

__nvim() {
    local _window="nvim"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --tab --name "main" \
                "${HOME}/dot/dot/d_nvim/" \
                "${HOME}/.config/nvim/" \
                \
                --tab --name "conf" \
                "${HOME}/dot/dot/d_nvim/.config/nvim/conf/rpre/plugin/external" \
                "${HOME}/dot/dot/d_nvim/.config/nvim/conf/rpre/pack/start/start/shrakula/lua/shrakula"
        )"
}

__tmux() {
    local _window="tmux"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --tab --name "main" \
                "${HOME}/dot/dot/d_tmux/" \
                "${HOME}/.config/tmux/" \
                \
                --tab --name "script" \
                "${HOME}/dot/dot/d_tmux/.config/tmux/script/" \
                "${HOME}/dot/dot/d_prv/.config/tmux/script"
        )"
}

__vifm() {
    local _window="vifm"

    if __has_window --session "${SESSION}" -- "${_window}"; then
        return
    fi

    __create_window \
        --session "${SESSION}" \
        --name "${_window}" \
        --cmd "$(
            __make_cmd_vifm \
                --tab --name "main" \
                "${HOME}/dot/dot/d_vifm/" \
                "${HOME}/.config/vifm/" \
                --tab --name "conf" \
                "${HOME}/dot/dot/d_vifm/.config/vifm/scripts/" \
                "${HOME}/dot/dot/d_vifm/src/"
        )"
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
                "${HOME}/dot/dot/d_mail/.local/share/mail/" \
                "${HOME}/dot/dot/d_mail/.config/neomutt/"
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
    __base
    __setup

    for _e in "common" "prv" "wm" "zsh" "mpv" "nvim" "tmux" "vifm" "mail"; do
        printf "%s\n" "${_e}"
    done | fzf --multi --reverse --height 37% | while read -r _line; do
        "__${_line}"
    done

    __attach_session "${SESSION}"
}
__main
