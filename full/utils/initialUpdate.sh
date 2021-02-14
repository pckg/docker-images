# locales + curl + sudo + timezone
apt-get -y update
apt-get install -y locales software-properties-common sudo curl apt-transport-https apt-utils tzdata openssl ca-certificates gnupg-agent
locale-gen en_US.UTF-8

# set timezone
echo Europe/Ljubljana > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata