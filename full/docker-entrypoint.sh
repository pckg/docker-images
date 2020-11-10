#!/bin/bash
set -e

if [ ! -f /home/developer/developer.ovpn ]; then
	echo "Mount .ovpn file to /home/developer/developer.ovpn"
fi

if [ ! -f /root/.ssh/id_rsa ]; then
	echo "Mount private key to /root/.ssh/id_rsa"
fi

if [ ! -f /root/.composer/auth.json ]; then
	echo "Mount composer auth to /root/.composer/auth.json"
fi

if [ -f /root/.ssh/id_rsa ]; then
  chmod 700 /root/.ssh
  chmod 644 /root/.ssh/id_rsa.pub
  chmod 600 /root/.ssh/id_rsa
fi

if [ -f /home/developer/developer.ovpn ]; then
  echo "Running VPN ..."
  openvpn --daemon --config /home/developer/developer.ovpn
fi

echo "Restart apache ..."
sudo /etc/init.d/apache2 start

# set git email
if [ -z "$PCKG_EMAIL" ]; then
	echo "Setting GIT email"
	git config --global user.email "$PCKG_EMAIL"
fi

# set git name
if [ -z "$PCKG_NAME" ]; then
	echo "Setting GIT name"
	git config --global user.name "$PCKG_NAME"
fi

echo "Preparing ..."
#exec "$@"

#/bin/bash
zsh
