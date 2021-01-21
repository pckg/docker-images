add-apt-repository ppa:ondrej/php
apt-get -y update
apt-get install -y mysql-client php7.4 php7.4-curl php7.4-intl php7.4-xml php7.4-mbstring php7.4-zip php7.4-mysql php7.4-cli php-amqplib php-ssh2 php7.4-zmq php7.4-imap php7.4-redis php7.4-bcmath php7.4-gd php7.4-bz2 php7.4-soap wget xvfb git zip unzip mysql-client cron
sudo update-alternatives --set php /usr/bin/php7.4