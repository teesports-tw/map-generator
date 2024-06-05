#!/bin/sh

find \
	-L "$1" \
	-iname \
	'*.map' \
	-type f \
	-printf \
	"add_vote \"%P\" \"sv_map %P\"\n" \
	| sed -e s@\.map\"@\"@gm > "$2" # /dev/null
