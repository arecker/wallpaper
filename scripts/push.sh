#!/usr/bin/env bash

log() {
    echo "push.sh: $1" 1>&2
}

DESTINATION="$1"

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

log "pushing photos to $DESTINATION"
rsync -avzh output/albums/Wallpaper/ "$DESTINATION"
