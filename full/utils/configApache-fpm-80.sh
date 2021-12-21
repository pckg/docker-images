# copy config
cp /usr/local/pckg-utils/external/etc_apache2_apache2-fpm.conf /etc/apache2/apache2.conf
cp /usr/local/pckg-utils/external/000-default-fpm-80.conf /etc/apache2/sites-enabled/000-default.conf
mkdir -p /etc/ssl/private/
cp /usr/local/pckg-utils/external/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
cp /usr/local/pckg-utils/external/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key

# enable apache modules
a2enmod expires headers rewrite ssl proxy_fcgi
a2enconf php8.0-fpm
