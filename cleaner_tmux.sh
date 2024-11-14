#!/bin/sh
tty_device=$(tmux display-message -p '#{pane_tty}' 2>/dev/null || tty)
exec kitty +kitten icat --clear --stdin no --silent --transfer-mode file </dev/null >"$tty_device"
