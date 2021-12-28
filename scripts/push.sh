#!/usr/bin/env bash

log() {
    echo "push.sh: $1" 1>&2
}

DESTINATION="$1"

use_sample() {
    [[ -n "$SAMPLE" ]]
}

log 'validating that $DESTINATION is set'
if [[ -z "${DESTINATION}" ]]; then
    log 'error!  $DESTINATION is not set!'
    exit 1
fi

log 'validating that photos exist'
if ! test -d output/albums/Wallpaper; then
    log 'error! Directory output/albums/Wallpaper does not exist!'
    exit 1
fi

if use_sample; then
    SOURCE="output/albums/Wallpaper/"
else
    log 'SAMPLE set, using ./sample as source'
    SOURCE="sample/"
fi

log "pushing photos in $SOURCE to $DESTINATION"
if use_sample; then
    rsync --delete -avzh "$SOURCE" "$DESTINATION"
else
    rsync -avzh "$SOURCE" "$DESTINATION"
fi
