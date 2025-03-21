#!/bin/sh
draw() {
	bat --color=always ~/.config/lf/empty.txt &
	kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$1" </dev/null >/dev/tty
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
	# vidthumb is from here:
	# https://raw.githubusercontent.com/duganchen/kitty-pistol-previewer/main/vidthumb
	draw "$(vidthumb "$file")"
	;;
esac

bat --color=always "$file"
