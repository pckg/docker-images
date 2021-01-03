FROM schtr4jh/pckg:base
MAINTAINER schtr4jh@schtr4jh.net

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

RUN sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
#RUN sudo systemctl enable --now docker

# change workdir for a developer
# USER developer
WORKDIR /var/www/html/

# cleanup
RUN rm -rf /var/lib/apt/lists/* /usr/local/pckg-utils

# open ports
# EXPOSE 80 443

# entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]