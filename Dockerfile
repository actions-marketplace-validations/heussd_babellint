FROM node:current-alpine

ENV   PYTHON_VERSION=3.8.8-r0 \
      GCC_VERSION=10.2.1_pre1-r3

RUN   apk add --no-cache --update \
      bash~=5.1.0-r0 \
      file~=5.39-r0 \
      git~=2.30.2-r0 \
      shellcheck~=0.7.1-r2 \
      # yamllint
      python3~=$PYTHON_VERSION \
      py3-pip~=20.3.4-r0 \
      python3-dev~=$PYTHON_VERSION \
      libxml2-dev~=2.9.10-r6 \
      libxslt-dev~=1.1.34-r0 \
      g++~=${GCC_VERSION} \
      gcc~=${GCC_VERSION} \
      # json linter
      jq~=1.6-r1 \
      # Spellcheck
      aspell~=0.60.8-r0 \
      aspell-en=2020.12.07-r0

RUN   pip3 install --no-cache-dir \
      pymdown-extensions==8.1.1 \
      pyspelling==2.7.2 \
      yamllint==1.26.1

RUN   npm install -g\
      markdownlint-cli@0.27.1

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