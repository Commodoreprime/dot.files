#!/bin/sh
# Backup the bookmark SQLite database for a defined Firefox profile
#  or have it attempt to find the most likely default profile automatically
# NOTE 1: Currently this (and is intended to) only work if it is running inside of a flatpak
# NOTE 2: This script does not currently check if Firefox is activly running,
#  there *may* be consequences if so. For data safety sake, make sure Firefox (or at least the profile)
#  is not running before running this script.
#

IS_FLATPAK=0
[ -f "/.flatpak-info" ] && IS_FLATPAK=1

if [ "$IS_FLATPAK" = 0 ]; then
	printf "This is not running in a flatpak environment!\n"
	printf "Try again instead with:\n$ flatpak run --command=bash org.mozilla.firefox -c '%s'\n" \
		"$(realpath "$0")"
	exit 1
fi

MOZILLA_PATH="$(grep 'instance-path' /.flatpak-info | cut -d'=' -f2)/.mozilla"

FF_PROFILE_REL_PATH="$1"
# If profile path is empty, try to guess via installs.ini
if [ -z "$FF_PROFILE_REL_PATH" ]; then
	installs_path="$MOZILLA_PATH/firefox/profiles.ini"
	# We assume "Profile0" is the default until im told otherwise!
	FF_PROFILE_REL_PATH="$(awk '/\[Profile0\]/' RS= "$installs_path" | grep 'Path' | cut -d'=' -f2)"
fi

# If the profile path is still empty, fail.
if [ -z "$FF_PROFILE_REL_PATH" ]; then
	printf "Was unable to find a Firefox profile (Path under Profile0 turned empty)\n"
	exit 1
fi

BKM_DB_PATH="$MOZILLA_PATH/firefox/$FF_PROFILE_REL_PATH/places.sqlite"
BKM_BACKUP_PATH="$MOZILLA_PATH/places.$(date '+%Y-%m-%d').backup.sqlite"

printf "Backing up %s to %s\n" "$BKM_DB_PATH" "$BKM_BACKUP_PATH"

sqlite3 "$BKM_DB_PATH" ".backup $BKM_BACKUP_PATH"

exit 0

