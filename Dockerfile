FROM ghcr.io/swirlclinic/mariposa:master

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