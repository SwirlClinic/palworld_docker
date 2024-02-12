#!/bin/bash

# Copypasta'd from https://github.com/CM2Walki/CSGO/blob/master/etc/entry.sh
mkdir -p "${STEAMAPPDIR}" || true   
mkdir -p "${STEAMAPPDIR}/${STEAMAPP}"

echo "Checking/Installing SteamCMD"
steamcmd +runscript "${APP}/${STEAMAPP}_update.txt"
chown -R "${USER}:${USER}" "${STEAMAPPDIR}" "${HOME}"

echo "STEAM_COMPAT_DATA_PATH=${STEAM_PATH}/steamapps/compatdata/${STEAMAPPID} ${PROTON} run ${STEAMAPPDIR}/Pal/Binaries/Win64/PalServer-Win64-Test.exe ${ADDITIONAL_ARGS}"
sudo -u ${USER} -H sh -c "STEAM_COMPAT_CLIENT_INSTALL_PATH=$STEAM_PATH STEAM_COMPAT_DATA_PATH=${STEAM_PATH}/steamapps/compatdata/${STEAMAPPID} ${PROTON} run ${STEAMAPPDIR}/Pal/Binaries/Win64/PalServer-Win64-Test.exe ${ADDITIONAL_ARGS}"