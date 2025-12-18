#!/bin/bash
file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

# Unique identifier for this preview
PREVIEW_ID="lf-preview-$$"

if [ -n "$TMUX" ]; then
	# TMUX MODE - Use temporary files
	case "$(file -Lb --mime-type "$file")" in
	image/*)
		tmpfile=$(mktemp "/tmp/${PREVIEW_ID}-XXXXXX.jpg")
		convert "$file" -resize "${w}x${h}" "$tmpfile"
		kitty +kitten icat --silent --stdin no --transfer-mode file \
			--place "${w}x${h}@${x}x${y}" "$tmpfile" </dev/null >/dev/tty
		echo "$tmpfile" # Pass temp path to cleaner
		;;
	video/*)
		tmpfile=$(mktemp "/tmp/${PREVIEW_ID}-XXXXXX.jpg")
		vidthumb "$file" "$tmpfile" # Assume vidthumb outputs to file
		kitty +kitten icat --silent --stdin no --transfer-mode file \
			--place "${w}x${h}@${x}x${y}" "$tmpfile" </dev/null >/dev/tty
		echo "$tmpfile"
		;;
	*)
		bat --color=always "$file"
		;;
	esac
else
	# DIRECT KITTY MODE
	case "$(file -Lb --mime-type "$file")" in
	image/* | video/*)
		kitty +kitten icat --silent --stdin no --transfer-mode file \
			--place "${w}x${h}@${x}x${y}" "$file" </dev/null >/dev/tty
		;;
	*)
		bat --color=always "$file"
		;;
	esac
fi
