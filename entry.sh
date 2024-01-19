#!/bin/bash

# Copypasta'd from https://github.com/CM2Walki/CSGO/blob/master/etc/entry.sh
mkdir -p "${STEAMAPPDIR}" || true   
mkdir -p "${STEAMAPPDIR}/${STEAMAPP}"

echo "Checking/Installing SteamCMD"
echo "${APP}/${STEAMAPP}_update.txt"

steamcmd +runscript "${APP}/${STEAMAPP}_update.txt"

sudo -u ${USERNAME} -H sh -c "${STEAMAPPDIR}/PalServer.sh" \
		"${ADDITIONAL_ARGS}" 