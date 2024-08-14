#!/bin/bash

# Set the gnome-terminal color theme
#
# The first time this is run the profile will not exist, so change it via GUI,
# e.g. uncheck 'Use colours from system theme'

if [[ "$#" -ne 1 ]]; then
    echo "usage: $(basename $0) <dark|light>" 1>&2
    exit 1
fi

profile=$(dconf dump /org/gnome/terminal/  | grep -m 1 '^\[legacy/profiles' | tr -d '[]')

if [[ -z "${profile}" ]]; then
    echo "Failed to get gnome-terminal profile name from dconf " 1>&2
    exit 1
fi

key="/org/gnome/terminal/${profile}"
dconf write "${key}/use-theme-colors" false

case "${1}" in
    "dark")
	# GNOME dark
	dconf write "${key}/background-color" "'rgb(23,20,33)'"
	dconf write "${key}/foreground-color" "'rgb(208,207,204)'"
	;;
    "light")
	# Tango light
	dconf write "${key}/background-color" "'rgb(238,238,236)'"
	dconf write "${key}/foreground-color" "'rgb(46,52,54)'"
	;;
esac
