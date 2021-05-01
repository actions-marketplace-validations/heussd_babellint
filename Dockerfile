FROM ubuntu

RUN   apt-get update && \
      apt-get -y install --no-install-recommends \
      # yamllint
      python3 python3-pip \
      # json linter
      jq \
      # Markdownlint
      ruby \
      aspell aspell-en \
      # Python dependencies
      python-lxml python3-dev libxml2-dev libxslt-dev g++ gcc zlib1g-dev \
      && rm -rf /var/lib/apt/lists/*


RUN   pip3 install yamllint pyspelling pymdown-extensions
RUN   gem install mdl

COPY babellint /usr/bin/
RUN chmod +x /usr/bin/babellint

COPY .config/ /root/.config/
COPY pyspelling-readme-md.yml /root/


ENTRYPOINT [ "/usr/bin/babellint" ]