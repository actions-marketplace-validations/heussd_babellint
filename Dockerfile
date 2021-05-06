FROM node:current-alpine

SHELL ["/bin/ash", "-o", "pipefail", "-c"]
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
      pymdown-extensions==8.1.1 \
      pyspelling==2.7.2 \
      yamllint==1.26.1

RUN   npm install -g\
      markdownlint-cli@~0.27


RUN   wget $(wget -q -O - https://api.github.com/repos/hadolint/hadolint/releases/latest \
                  | jq -r \
                  '.assets[] | select(.browser_download_url | contains("Linux")) | .browser_download_url') \
            --no-verbose \
            --output-document=/usr/bin/hadolint && \
            chmod +x /usr/bin/hadolint


COPY yamllint.config pyspelling-readme-md.yml /root/

WORKDIR /
COPY babellint ./
RUN chmod +x babellint


ENTRYPOINT [ "/babellint" ]