#!/usr/bin/env bash
set -e

log() {
    echo "pull.sh: $1" 1>&2
}

log 'installing latest gphotos-sync'
log "using pip at $(which pip)"
~/.pyenv/shims/pip install --upgrade gphotos-sync

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

log "using gphotos-sync at $(which gphotos-sync)"
~/.local/bin/gphotos-sync \
    --album "Wallpaper" \
    --use-hardlinks \
    --omit-album-date \
    --skip-video \
    --secret "$WALLPAPER_SECRETS" \
    --use-flat-path \
    ./output
