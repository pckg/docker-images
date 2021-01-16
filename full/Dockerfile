FROM schtr4jh/pckg:base
MAINTAINER schtr4jh@schtr4jh.net

# add utils so we can optimize a few things
RUN cp -R utils /usr/local/pckg-utils

# backend services = lsyncd + redis server + rabbitmq server + mysql server + openvpn
RUN sh /usr/local/pckg-utils/installBackend.sh

# worker = php + apache + mysql
RUN sh /usr/local/pckg-utils/installWeb.sh

# copy apache config
RUN sh /usr/local/pckg-utils/configApache.sh

# composer + node + npm + yarn + less + webpack
RUN sh /usr/local/pckg-utils/installFrontend.sh

# install developer user + utils + bitbucket + github + zsh + certificate + openvpn
RUN sh /usr/local/pckg-utils/installDeveloper.sh

# install docker
RUN sh /usr/local/pckg-utils/installDocker.sh

# change workdir for a developer
# USER developer
WORKDIR /var/www/html/

# entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]