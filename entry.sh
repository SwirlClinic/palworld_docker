#!/bin/bash

# Copypasta'd from https://github.com/CM2Walki/CSGO/blob/master/etc/entry.sh
mkdir -p "${STEAMAPPDIR}" || true   
mkdir -p "${STEAMAPPDIR}/${STEAMAPP}"

echo "Checking/Installing SteamCMD"
steamcmd +runscript "${APP}/${STEAMAPP}_update.txt"
chown -R "${USER}:${USER}" "${STEAMAPPDIR}" "${HOME}"

echo "${STEAMAPPDIR}/PalServer.sh ${ADDITIONAL_ARGS}"
sudo -u ${USER} -H sh -c "${STEAMAPPDIR}/PalServer.sh ${ADDITIONAL_ARGS}"