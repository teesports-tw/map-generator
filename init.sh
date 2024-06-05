#!/bin/sh

# --- Functions ---

# Echoes
error() { TAIL=$(defaults "$3" ', exiting...') ; echo "[$1][error] $2$TAIL" ; exit 1 ; }
output() { TAIL=$(defaults "$4" ', keep going...') ; echo "[$1][$2] $3$TAIL" ; }

# Default value wrapper
defaults() { if [ -z "$1" ] ; then echo "$2" ; else echo "$1" ; fi }

# -----------------

# Scripts location
MERGED_SH="./merged.sh"
# SPLITTED_SH="./splitted.sh"

MAPS_DIRECTORY=$(defaults "$MAPS_DIRECTORY" './maps')
output main info "MAPS_DIRECTORY set as '$MAPS_DIRECTORY'"

MODE=$(defaults "$MODE" 'merged')
output main info "MODE set as '$MODE'"
if [ "$MODE" != 'merged' ] && [ "$MODE" != 'splitted' ]
then error main "MODE $MODE is not 'merged' or 'splitted'" ; fi

# File there votes are stored
VOTES_FILE=$(defaults "$VOTES_FILE" './votes')
output main info "VOTES_PATH set as '$VOTES_FILE'"

# Directory there votes are stored
VOTES_DIR=$(defaults "$VOTES_DIR" './votes')
output main info "VOTES_DIR set as '$VOTES_DIR'"

output main info "All looks fine"

case "$MODE" in
	merged )
		output generator info "filling $VOTES_FILE" 'with votes...'
		if [ -d "$VOTES_FILE" ]
		then
			error main "$VOTES_FILE is NOT a file"
		else
			"$MERGED_SH" "$MAPS_DIRECTORY" "$VOTES_FILE"
		fi
		;;
	splitted )
		error generator "MODE $MODE is not supported now and will me implemented later... " 'Maybe...'
		# output generator info "filling $VOTES_DIR" 'with votes...'
		# if ! [ -e "$VOTES_DIR" ]
		# then
		# 	error main "$VOTES_DIR does not exist"
		# elif ! [ -d "$VOTES_DIR" ]
		# then
		# 	error main "$VOTES_DIR is not a directory"
		# else
		# 	"$SPLITTED_SH" "$MAPS_DIRECTORY" "$VOTES_DIR"
		# fi
		;;
esac

output main info 'Looks like votes generated correctly' 'exiting...'
