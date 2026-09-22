#!/usr/bin/env bash

declare -x MINECRAFT_DATA_MODS_DIR
: "${MINECRAFT_DATA_MODS_DIR:="${MINECRAFT_DATA_DIR}/mods"}"

if [ ! -d "${MINECRAFT_DATA_MODS_DIR}" ]; then
    echo "> creating mods dir"
    mkdir -p "${MINECRAFT_DATA_MODS_DIR}"
fi

if [ -d "${MINECRAFT_MODS_DIR}" ] && [ ! -L "${MINECRAFT_MODS_DIR}" ]; then
    echo "> migrating bundled mods"
    find "${MINECRAFT_MODS_DIR}" -mindepth 1 -maxdepth 1 -exec cp -an {} "${MINECRAFT_DATA_MODS_DIR}/" \;
    rm -rf "${MINECRAFT_MODS_DIR}"
fi

if [ ! -L "${MINECRAFT_MODS_DIR}" ]; then
    echo "> creating mods symlink"
    ln -sfn "${MINECRAFT_DATA_MODS_DIR}" "${MINECRAFT_MODS_DIR}"
fi

true
