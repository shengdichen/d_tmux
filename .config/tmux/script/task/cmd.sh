#!/usr/bin/env dash

__ascii() {
    __matrix() {
        cmatrix \
            -a -u 5 \
            -m \
            -b -C white
    }

    __aqua() {
        asciiquarium | lolcat
    }

    __bs() {
        while true; do
            clear
            for _v in $(bullshit); do
                printf -- "%s\n" "${_v}"
            done | head -n 4 | toilet -f smblock --gay -F border
            sleep 5
        done
    }

    __fort() {
        while true; do
            clear
            fortune -o | cowsay -s | lolcat
            read -r _
        done
    }

    local _choice
    _choice="$(for _e in "matrix" "aqua" "bs" "fort"; do
        printf "%s\n" "${_e}"
    done | fzf --reverse)"

    if [ ! "${_choice}" ]; then
        _choice="fort"
    fi

    "__${_choice}"
}

__top() {
    while true; do
        top \
            -d 1.3 \
            -E G
        s-tui
        nvtop --no-color
    done
}

__free() {
    watch \
        -n 1.3 \
        "free -h"
}

__time() {
    while true; do
        date "+%Y.%b.%d" | toilet -f future
        date "+%p, %V->%a; %Z@%z"
        date "+%H:%M:%S" | toilet -f future --metal | lolcat

        sleep 1.0
        clear
    done
}

__pulsemixer() {
    pulsemixer --color 0
}

case "${1}" in
    "--top")
        shift
        __top
        ;;
    "--free")
        __free
        __top
        ;;
    "--time")
        shift
        __time
        ;;
    "--pulse")
        shift
        __pulsemixer
        ;;
    *)
        __ascii
        ;;
esac
