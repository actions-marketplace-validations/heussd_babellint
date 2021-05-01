FROM ubuntu

RUN   apt-get update && \
      apt-get -y install --no-install-recommends \
      # yamllint
      python3 python3-pip \
      # json linter
      jq \
      # Markdownlint
      ruby \
      && rm -rf /var/lib/apt/lists/*


RUN   pip3 install yamllint
RUN   gem install mdl

COPY babellint /usr/bin/
RUN chmod +x /usr/bin/babellint

COPY .config/ /root/.config/


ENTRYPOINT [ "/usr/bin/babellint" ]