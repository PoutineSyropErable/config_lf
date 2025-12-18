#!/bin/bash
# Read tempfile path from stdin if provided
while read -r tmpfile; do
	[ -f "$tmpfile" ] && rm -f "$tmpfile"
done

# Always attempt to clear
exec kitty +kitten icat --clear --stdin no --silent --transfer-mode file </dev/null >/dev/tty

# Additional tmux session cleanup
if [ -n "$TMUX" ]; then
	for pid in $(pgrep -f "lf-preview-"); do
		kill "$pid" 2>/dev/null
	done
fi
