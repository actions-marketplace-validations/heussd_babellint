FROM node:current-alpine


RUN   apk add --no-cache --update \
      bash \
      git \
      # yamllint
      python3 py-pip python3-dev libxml2-dev libxslt-dev g++ gcc \
      # json linter
      jq \
      # Spellcheck
      aspell aspell-en

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