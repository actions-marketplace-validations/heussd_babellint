FROM node:current-alpine


RUN   apk add --no-cache --update \
      bash \
      # yamllint
      python3 py-pip python3-dev libxml2-dev libxslt-dev g++ gcc \
      # json linter
      jq \
      # Spellcheck
      aspell aspell-en

RUN   pip3 install yamllint pyspelling pymdown-extensions

RUN   npm install -g markdownlint-cli

WORKDIR /
COPY babellint ./
RUN chmod +x babellint

COPY .config/ /root/.config/
COPY pyspelling-readme-md.yml /root/


ENTRYPOINT [ "/babellint" ]