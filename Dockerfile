FROM debian:11.6-slim

ARG SHA256="9b68f53f9caa1cc9332b0e3f6a176ccdff6f08e92f212fb821656048ddc0321b"
ARG VERSION="0.8.1"
ARG FILENAME="rubyfmt-v${VERSION}-Linux.tar.gz"
ARG TARGET_PATH="/usr/local/bin/rubyfmt"

RUN apt-get update && apt-get install -y wget

RUN wget "https://github.com/fables-tales/rubyfmt/releases/download/v${VERSION}/${FILENAME}"

RUN echo "${SHA256}  ${FILENAME}" | sha256sum -c &&\
      tar -xOf ${FILENAME} tmp/releases/v${VERSION}-Linux/rubyfmt > ${TARGET_PATH} &&\
      chmod +x ${TARGET_PATH} &&\
      rm ${FILENAME}

ENTRYPOINT ["rubyfmt"]
