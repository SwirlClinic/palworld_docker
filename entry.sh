#!/bin/bash

# Copypasta'd from https://github.com/CM2Walki/CSGO/blob/master/etc/entry.sh
mkdir -p "${STEAMAPPDIR}" || true   
mkdir -p "${STEAMAPPDIR}/${STEAMAPP}"

echo "Checking/Installing SteamCMD"
echo "${APP}/${STEAMAPP}_update.txt"

steamcmd +runscript "${APP}/${STEAMAPP}_update.txt"
chown -R "${USERNAME}:${USERNAME}" "${STEAMAPPDIR}"
mkdir -p /home/steam/.steam/sdk64
ln -s "${STEAMAPPDIR}/linux64/steamclient.so" "/home/steam/.steam/sdk64/steamclient.so"

sudo -u ${USERNAME} -H sh -c "${STEAMAPPDIR}/PalServer.sh" \
		"${ADDITIONAL_ARGS}" 