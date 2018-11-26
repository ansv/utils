#!/bin/bash

U=$(cat "$(dirname "$0")/.user")
D=$(cat "$(dirname "$0")/.domain")
P=x
if [ -z "${1:-}" ]; then
    read -p "password for $U: " -s P
    echo
fi

OPTS=username=$U,password=$P,domain=$D,uid=$UID,file_mode=0700,dir_mode=0700,nobrl,iocharset=utf8

function mm {
    local OPT="$1"
    local WHAT="$2"
    local WHERE="$3"
    case "$OPT" in
    (--)
        mkdir -p "$WHERE"
        sudo mount -t cifs -o "$OPTS" "$WHAT" "$WHERE"
        ;;
    (-u|-x)
        [ ! -d "$WHERE" ] || {
            sudo umount "$WHERE"
            rmdir "$WHERE"
            rmdir --ignore-fail-on-non-empty "$(dirname "$WHERE")"
        }
        ;;
    (*)
        echo "usage:"
        echo "  %0  # for mount"
        echo "or"
        echo "  %0 -x  # for unmount"
        exit 1
    esac
}

cat "$(dirname "$0")/.mntab" |
    while read what where; do mm "${1:---}" $what $where; done

# vim: ts=4 sw=4 et ft=sh
