# install utils
apt-get install -y iputils-ping nano net-tools zsh openvpn gcc g++ make build-essential
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# iproute

# add user
sh /usr/local/pckg-utils/addDeveloper.sh

# bitbucket and github
mkdir -p /root/.ssh
echo "Host github.com\n\tStrictHostKeyChecking no\nHost bitbucket.org\n\tStrictHostKeyChecking no" >> /root/.ssh/config

# install self-signed certificate
sh /usr/local/pckg-utils/copyCertificates.sh