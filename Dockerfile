ARG ARCH="x86_64"
ARG BASE_IMAGE="debian:12-slim"

FROM $BASE_IMAGE AS builder

ARG SHA256="619535a281c64874a4fc74dd55ebbdbc5b9d788a063bfca47bc2e25b5c18464a"
ARG VERSION="0.10.0"
ARG TARGET_PATH="/usr/local/bin/rubyfmt"
ARG FILENAME="/tmp/rubyfmt.tar.gz"

RUN apt-get update -y && apt-get install -y curl && \
      curl -0L -s "https://github.com/fables-tales/rubyfmt/releases/download/v${VERSION}/rubyfmt-v${VERSION}-Linux-${ARCH}.tar.gz" --output $FILENAME && \
      echo "${SHA256}  ${FILENAME}" | sha256sum -c && \
      tar -xOf ${FILENAME} tmp/releases/v${VERSION}-Linux/rubyfmt > ${TARGET_PATH} && \
      chmod +x ${TARGET_PATH} && \
      apt-get purge -y --auto-remove curl && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM $BASE_IMAGE

ARG PUID="1000"
ARG PGID="1000"
ARG USERNAME="rubyfmt-user"
ARG TARGET_PATH="/usr/local/bin/rubyfmt"

RUN groupadd --gid $PGID $USERNAME && \
      useradd --uid $PUID --gid $PGID -m $USERNAME

COPY --from=builder ${TARGET_PATH} ${TARGET_PATH}

USER $USERNAME
WORKDIR /home/$USERNAME

ENTRYPOINT ["rubyfmt"]
