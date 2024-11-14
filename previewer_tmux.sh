#!/bin/sh
draw() {
	tty_device=$(tmux display-message -p '#{pane_tty}' 2>/dev/null || tty)
	kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$1" </dev/null >"$tty_device"
	exit 1
}

file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

case "$(file -Lb --mime-type "$file")" in
image/*)
	draw "$file"
	;;
video/*)
	draw "$(vidthumb "$file")"
	;;
esac

bat --color=always --style=plain --pager=never "$file"
