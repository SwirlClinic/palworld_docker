FROM ghcr.io/swirlclinic/mariposa:master

ENV APP "/app"
ENV STEAMAPPID 2394010 
ENV STEAMAPP palworld
ENV STEAMCMDDIR "${HOME}/.local/share/Steam/steamcmd"
ENV STEAMAPPDIR "${APP}/${STEAMAPP}-dedicated"

ENV ADDITIONAL_ARGS=""

ENV USERNAME=steam
ENV HOMEDIR "/home/${USERNAME}"
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

# set -x will print all commands to terminal
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		sudo \
		wget \
		ca-certificates \
		lib32gcc-s1 lib32stdc++6 \
		lib32z1 \
		libtinfo5:i386 \
		libncurses5:i386 \
		libcurl3-gnutls:i386 \
		xdg-user-dirs xdg-utils \
	&& echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'login anonymous'; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${APP}/${STEAMAPP}_update.txt"

COPY entry.sh "${APP}/"

RUN chmod +x "${APP}/entry.sh" \
	&& chown "${USERNAME}:${USERNAME}" "${APP}/entry.sh" "${APP}/${STEAMAPP}_update.txt" \
	&& rm -rf /var/lib/apt/lists/* 

# RUN ln -s "${STEAMCMDDIR}/linux32/steamclient.so" "${STEAMCMDDIR}/steamservice.so" \
#                 && mkdir -p "${HOMEDIR}/.steam/sdk32" \
#                 && ln -s "${STEAMCMDDIR}/linux32/steamclient.so" "${HOMEDIR}/.steam/sdk32/steamclient.so" \
#                 && ln -s "${STEAMCMDDIR}/linux32/steamcmd" "${STEAMCMDDIR}/linux32/steam" \
#                 && mkdir -p "${HOMEDIR}/.steam/sdk64" \
#                 && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "${HOMEDIR}/.steam/sdk64/steamclient.so" \
#                 && ln -s "${STEAMCMDDIR}/linux64/steamcmd" "${STEAMCMDDIR}/linux64/steam" \
#                 && ln -s "${STEAMCMDDIR}/steamcmd.sh" "${STEAMCMDDIR}/steam.sh"
	
# RUN ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" 

# RUN chmod a+X /root
# RUN chown -R "${USERNAME}:${USERNAME}" "${STEAMCMDDIR}" "${HOMEDIR}/.steam"

VOLUME ${STEAMAPPDIR}

USER ${USER}

WORKDIR ${APP}

CMD ["bash", "entry.sh"]
ENTRYPOINT []
# Expose ports
EXPOSE 8221/udp