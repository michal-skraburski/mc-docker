#!/usr/bin/env bash

declare -x MINECRAFT_CRASH_REPORTS_DIR
: "${MINECRAFT_CRASH_REPORTS_DIR:="${MINECRAFT_DATA_DIR}/crash-reports"}"

if [ ! -d "${MINECRAFT_CRASH_REPORTS_DIR}" ]; then
    echo "> creating crash-reports dir"
    mkdir -p "${MINECRAFT_CRASH_REPORTS_DIR}"
fi

if [ -d "${MINECRAFT_GAME_DIR}/crash-reports" ] && [ ! -L "${MINECRAFT_GAME_DIR}/crash-reports" ]; then
    echo "> migrating existing crash reports"
    find "${MINECRAFT_GAME_DIR}/crash-reports" -mindepth 1 -maxdepth 1 \
        -exec cp -an {} "${MINECRAFT_CRASH_REPORTS_DIR}/" \;
    rm -rf "${MINECRAFT_GAME_DIR}/crash-reports"
fi

if [ ! -L "${MINECRAFT_GAME_DIR}/crash-reports" ]; then
    echo "> creating crash-reports symlink"
    ln -sfn "${MINECRAFT_CRASH_REPORTS_DIR}" "${MINECRAFT_GAME_DIR}/crash-reports"
fi

true
