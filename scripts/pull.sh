#!/usr/bin/env bash
set -e

log() {
    echo "pull.sh: $1" 1>&2
}

log 'validating that $WALLPAPER_SECRETS is set'
if [[ -z "${WALLPAPER_SECRETS}" ]]; then
    log 'error!  $WALLPAPER_SECRETS is not set!'
    exit 1
fi

log 'validating that $WALLPAPER_SECRETS exists'
if ! test -f "$WALLPAPER_SECRETS"; then
    log 'error!  $WALLPAPER_SECRETS does not exist!'
    exit 1
fi

log 'pulling photos from album'
gphotos-sync \
    --album "Wallpaper" \
    --use-hardlinks \
    --omit-album-date \
    --skip-video \
    --secret "$WALLPAPER_SECRETS" \
    --use-flat-path \
    ./output
