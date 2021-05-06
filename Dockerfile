FROM node:current-alpine

ENV   PYTHON_VERSION=3 \
      GCC_VERSION=10

RUN   apk add --no-cache --update \
      bash~=5 \
      file~=5 \
      git~=2 \
      shellcheck~=0.7 \
      # yamllint
      python3~=$PYTHON_VERSION \
      py3-pip~=20 \
      python3-dev~=$PYTHON_VERSION \
      libxml2-dev~=2 \
      libxslt-dev~=1 \
      g++~=${GCC_VERSION} \
      gcc~=${GCC_VERSION} \
      # json linter
      jq~=1 \
      # Spellcheck
      aspell~=0.60 \
      aspell-en=2020.12.07-r0

RUN   pip3 install --no-cache-dir \
      pymdown-extensions~=8.0.0 \
      pyspelling~=2.0.0 \
      yamllint~=1.0.0

RUN   npm install -g\
      markdownlint-cli@~0.27

RUN   wget https://github.com/hadolint/hadolint/releases/download/v2.3.0/hadolint-Linux-x86_64 \
            --no-verbose \
            --output-document=/usr/bin/hadolint && \
            chmod +x /usr/bin/hadolint

WORKDIR /
COPY babellint ./
RUN chmod +x babellint

COPY .config/ /root/.config/
COPY pyspelling-readme-md.yml /root/


ENTRYPOINT [ "/babellint" ]