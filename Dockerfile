FROM ghcr.io/swirlclinic/mariposa:proton

ENV STEAMAPPID 2394010 
ENV STEAMAPP palworld
ENV STEAMAPPDIR "${APP}/${STEAMAPP}-dedicated"
ENV ADDITIONAL_ARGS=""

# set -x will print all commands to terminal
RUN set -x \
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

ENV STEAM_PATH="${HOME}/.steam/steam"
ENV STEAM_COMPAT_CLIENT_INSTALL_PATH=$STEAM_PATH
ENV STEAM_COMPAT_DATA_PATH=${STEAM_PATH}/steamapps/compatdata/${STEAMAPPID}
RUN mkdir -p "${STEAM_COMPAT_DATA_PATH}"

# RUN set -x \
# 	&& wget https://aka.ms/vs/17/release/vc_redist.x86.exe -O /tmp/vc_redist.x86.exe \
# 	&& wget https://aka.ms/vs/17/release/vc_redist.x64.exe -O /tmp/vc_redist.x64.exe \
# 	&& ${PROTON} run "/tmp/vc_redist.x64.exe /install /passive /norestart" \
# 	&& ${PROTON} run "/tmp/vc_redist.x86.exe /install /passive /norestart"
	
RUN cp -r ${PROTON_DIR}/${PROTON_VERSION}/files/share/default_pfx ${STEAM_COMPAT_DATA_PATH}
#CMD ["bash", "entry.sh"]
ENTRYPOINT ["bash", "entry.sh"]
# Expose ports
EXPOSE 8211/udp \
		27015