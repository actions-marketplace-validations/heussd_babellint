# syntax=docker/dockerfile:1.4
FROM alpine:3 as hadolint

SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN   apk add --no-cache --update wget=1.21.2-r2 jq=1.6-r1 ca-certificates=20211220-r0
RUN   wget "$(wget -q -O - https://api.github.com/repos/hadolint/hadolint/releases/latest | jq -r '.assets[] | select(.browser_download_url | contains("Linux")) | .browser_download_url' | grep "$(apk --print-arch)")" --no-verbose --output-document=/hadolint



FROM node:current-buster

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV   PYTHON_VERSION=3* \
      GCC_VERSION=10*

RUN   apt-get update && \
      apt-get -y install --no-install-recommends \
      bash=5* \
      file=1* \
      git=1* \
      shellcheck=0* \
      # yamllint
      python3=$PYTHON_VERSION \
      python3-dev=${PYTHON_VERSION} \
      python3-pip=18* \
      python3-setuptools=40* \
      # json linter
      jq=1* \
      && rm -rf /var/lib/apt/lists/*

RUN   pip3 install --no-cache-dir \
      yamllint==1.26.1 \
      flake8==3.9.1

RUN   npm install -g\
      markdownlint-cli@~0.27


COPY yamllint.config /
COPY markdownlint.yml /
RUN  chmod 755 /yamllint.config

WORKDIR /usr/bin/
COPY --link --from=hadolint --chmod=0755 /hadolint /

WORKDIR /
COPY babellint ./
RUN chmod +x babellint


ENTRYPOINT [ "/babellint" ]
