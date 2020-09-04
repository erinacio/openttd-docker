FROM debian:stretch
COPY build /build/
RUN ["/bin/sh", "/build/install.sh"]
USER openttd:openttd
WORKDIR /data
EXPOSE 3979
EXPOSE 3979/udp
ENTRYPOINT ["/usr/games/openttd"]
