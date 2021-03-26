apt-get install -y php-dev
PREVDIR=$PWD
cd /tmp/
git clone --recursive --depth=1 https://github.com/kjdev/php-ext-snappy.git
cd php-ext-snappy
phpize
./configure
make
make install
echo "extension=snappy" >> /etc/php/8.0/cli/php.ini
cd $PREVDIR
