add-apt-repository ppa:ondrej/php
add-apt-repository ppa:ondrej/apache2
apt-get -y update
apt-get install -y mysql-client postgresql-client apache2 libapache2-mod-fcgid php8.0 php8.0-fpm php8.0-curl php8.0-intl php8.0-xml php8.0-mbstring php8.0-zip php8.0-mysql php8.0-pgsql php8.0-cli php-amqplib php8.0-ssh2 php8.0-zmq php8.0-imap php8.0-redis php8.0-bcmath php8.0-gd php8.0-bz2 php8.0-soap php8.0-dev wget xvfb git zip unzip
#php-pcntl

update-alternatives --set php /usr/bin/php8.0
