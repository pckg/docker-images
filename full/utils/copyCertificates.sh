mkdir -p /etc/ssl/certs
mkdir -p /etc/ssl/private
cp /usr/local/pckg-utils/external/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
cp /usr/local/pckg-utils/external/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key