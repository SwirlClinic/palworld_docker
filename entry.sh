#!/bin/bash

# Copypasta'd from https://github.com/CM2Walki/CSGO/blob/master/etc/entry.sh
mkdir -p "${STEAMAPPDIR}" || true   
mkdir -p "${STEAMAPPDIR}/${STEAMAPP}"

echo "Checking/Installing SteamCMD"
steamcmd +runscript "${APP}/${STEAMAPP}_update.txt"

if [ ! -f "${STEAMAPPDIR}/Pal/Binaries/Win64/dwmapi.dll" ]; then
    echo "Installing UE4SS"
    apt-get update && apt-get install -y unzip
    rm -rf /var/lib/apt/lists/*
    wget https://github.com/UE4SS-RE/RE-UE4SS/releases/download/v3.0.0/UE4SS_v3.0.0.zip -O /tmp/UE4SS.zip
    unzip /tmp/UE4SS.zip -d /tmp/UE4SS
    mkdir -p ${STEAMAPPDIR}/Pal/Binaries/Win64/Mods
    mv /tmp/UE4SS/Mods/* ${STEAMAPPDIR}/Pal/Binaries/Win64/Mods/
    mv /tmp/UE4SS/UE4SS.dll /tmp/UE4SS/dwmapi.dll /tmp/UE4SS/UE4SS-settings.ini ${STEAMAPPDIR}/Pal/Binaries/Win64/
fi

chown -R "${USER}:${USER}" "${STEAMAPPDIR}" "${HOME}"

CMD="STEAM_COMPAT_CLIENT_INSTALL_PATH=$STEAM_PATH STEAM_COMPAT_DATA_PATH=${STEAM_PATH}/steamapps/compatdata/${STEAMAPPID} ${PROTON} run ${STEAMAPPDIR}/Pal/Binaries/Win64/PalServer-Win64-Test.exe ${ADDITIONAL_ARGS}"
echo $CMD
sudo -u ${USER} -H sh -c "${CMD}"