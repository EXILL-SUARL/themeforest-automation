#!/usr/bin/env bash

if [[ -z "${1}" ]]; then
    echo "Target directory is missing."
    exit;
fi

find $1 -iregex '.*\.\(jpg\|gif\|ico\|png\|jpeg\|webp\)$' -type f -exec convert -blur 0x20 {} {} \;
