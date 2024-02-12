FROM ghcr.io/swirlclinic/mariposa:proton

ENV STEAMAPPID 2394010 
ENV STEAMAPP palworld
ENV STEAMAPPDIR "${APP}/${STEAMAPP}-dedicated"
ENV ADDITIONAL_ARGS=""

ENV STEAM_PATH="${HOME}/.steam/steam"
ENV STEAM_COMPAT_CLIENT_INSTALL_PATH=$STEAM_PATH
ENV STEAM_COMPAT_DATA_PATH=${STEAM_PATH}/steamapps/compatdata/${STEAMAPPID}

# set -x will print all commands to terminal
RUN set -x \
&& mkdir -p "${STEAM_COMPAT_DATA_PATH}" \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo '@sSteamCmdForcePlatformType windows'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'login anonymous'; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${APP}/${STEAMAPP}_update.txt"

COPY entry.sh "${APP}/"

RUN chmod +x "${APP}/entry.sh" \
	&& chown "${USERNAME}:${USERNAME}" "${APP}/entry.sh" "${APP}/${STEAMAPP}_update.txt"

RUN chmod a+X /root
RUN chown -R "${USERNAME}:${USERNAME}" "${HOME}"

VOLUME ${STEAMAPPDIR}

WORKDIR ${APP}

CMD ["bash", "entry.sh"]
ENTRYPOINT []
# Expose ports
EXPOSE 8211/udp \
		27015