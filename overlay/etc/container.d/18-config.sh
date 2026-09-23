#!/usr/bin/env bash

declare -x MINECRAFT_CONFIG_DIR
: "${MINECRAFT_CONFIG_DIR:="${MINECRAFT_DATA_DIR}/config"}"

if [ ! -d "${MINECRAFT_CONFIG_DIR}" ]; then
    echo "> creating config dir"
    mkdir -p "${MINECRAFT_CONFIG_DIR}"
fi

# Mods ship defaults into the game dir; keep them but let the data dir win.
if [ -d "${MINECRAFT_GAME_DIR}/config" ] && [ ! -L "${MINECRAFT_GAME_DIR}/config" ]; then
    echo "> migrating bundled config"
    find "${MINECRAFT_GAME_DIR}/config" -mindepth 1 -maxdepth 1 \
        -exec cp -an {} "${MINECRAFT_CONFIG_DIR}/" \;
    rm -rf "${MINECRAFT_GAME_DIR}/config"
fi

if [ ! -L "${MINECRAFT_GAME_DIR}/config" ]; then
    echo "> creating config symlink"
    ln -sfn "${MINECRAFT_CONFIG_DIR}" "${MINECRAFT_GAME_DIR}/config"
fi

true
