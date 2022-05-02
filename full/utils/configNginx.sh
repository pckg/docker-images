# copy config
cp /usr/local/pckg-utils/external/etc_apache2_apache2.conf /etc/apache2/apache2.conf
cp /usr/local/pckg-utils/external/000-default.conf /etc/apache2/sites-enabled/000-default.conf
mkdir -p /etc/ssl/private/
cp /usr/local/pckg-utils/external/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
cp /usr/local/pckg-utils/external/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key

# enable apache modules
a2dismod php8.1
a2enmod expires headers rewrite ssl
