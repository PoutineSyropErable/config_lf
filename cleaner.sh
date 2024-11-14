#!/bin/sh
# cat /home/francois/.config/lf/empty.txt &
exec kitty +kitten icat --clear --stdin no --silent --transfer-mode file </dev/null >/dev/tty
