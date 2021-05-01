FROM ubuntu

RUN   apt-get update && \
      apt-get -y install --no-install-recommends \
      jq python3 python3-pip \
      && rm -rf /var/lib/apt/lists/*


RUN   pip3 install yamllint

COPY babellint /usr/bin/
RUN chmod +x /usr/bin/babellint

COPY .config/ /root/.config/


ENTRYPOINT [ "/usr/bin/babellint" ]