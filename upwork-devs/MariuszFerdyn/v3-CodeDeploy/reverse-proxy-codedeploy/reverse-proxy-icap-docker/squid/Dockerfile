FROM ubuntu:bionic
ENV DEBIAN_FRONTEND=noninteractive
COPY squid-deb-packages/squid-common.deb .
COPY squid-deb-packages/squid.deb .
RUN  apt update ; dpkg -i squid*.deb ; apt install -f -y ; apt install -y sudo python3 ca-certificates ; \
    apt clean all -y ; rm -rf /var/lib/apt/lists/* ; rm squid*.deb 
COPY squid.conf /etc/squid
COPY rewriter /etc/squid
COPY squid.pem /etc/squid
COPY entrypoint.sh /
RUN touch /var/log/squid/urlrewrite.log ; chown proxy:proxy /var/log/squid/ /etc/squid -R ; touch /first-run
ENTRYPOINT ["/entrypoint.sh"]
