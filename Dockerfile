ARG BASE_IMAGE="debian:12-slim"
FROM $BASE_IMAGE AS builder

ENV ARCH="x86_64"
ENV SHA256="c72f5dc2bc320b758cf963e7338d27ab71dc1cff894a4b139e3fdcefb2e23c17"
ENV VERSION="0.10.0"
ENV TARGET_PATH="/usr/local/bin/rubyfmt"
ENV FILENAME="/tmp/rubyfmt.tar.gz"

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
ENV TARGET_PATH="/usr/local/bin/rubyfmt"

RUN groupadd --gid $PGID $USERNAME && \
      useradd --uid $PUID --gid $PGID -m $USERNAME

COPY --from=builder ${TARGET_PATH} ${TARGET_PATH}

USER $USERNAME
WORKDIR /home/$USERNAME

ENTRYPOINT ["rubyfmt"]
