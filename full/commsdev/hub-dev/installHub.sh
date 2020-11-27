# we need to copy files to the web folder

cp /usr/local/commsdev-utils/package.json /var/www/
cp /usr/local/commsdev-utils/webpack.base.js /var/www/
cp /usr/local/commsdev-utils/webpack.config.js /var/www/
cp /usr/local/commsdev-utils/webpack.serve.js /var/www/

cp /usr/local/commsdev-utils/build.sh /var/www/
cp /usr/local/commsdev-utils/preview.sh /var/www/
cp /usr/local/commsdev-utils/zip.sh /var/www/

# install zip
apt-get install zip -y

# install dependencies
yarn install