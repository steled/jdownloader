FROM ubuntu:latest

LABEL dockerhub="https://hub.docker.com/r/steled/jdownloader" \
      github="https://github.com/steled/jdownloader" \
      maintainer.name="Stephan" \
      maintainer.github="https://github.com/steled" \
      maintainer.dockerhub="https://hub.docker.com/u/steled"

STOPSIGNAL SIGTERM

ENV JD_EMAIL="" \
    JD_PASSWORD="" \
    JD_DEVICENAME="" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    LOG_FILE="/dev/null" \
    JAVA_OPTIONS="" \
    UMASK=""

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        openjdk-17-jre-headless \
        ffmpeg \
        unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /jdownloader

COPY docker-entrypoint.sh \
    functions.sh \
    setup.sh \
    org.jdownloader.extensions.eventscripter.EventScripterExtension.json \
    org.jdownloader.extensions.eventscripter.EventScripterExtension.scripts.json \
    ./

RUN chmod 777 \
    . \
    docker-entrypoint.sh \
    functions.sh \
    setup.sh \
    org.jdownloader.extensions.eventscripter.EventScripterExtension.json \
    org.jdownloader.extensions.eventscripter.EventScripterExtension.scripts.json

CMD ["/bin/bash", "-c", "./docker-entrypoint.sh"]
