sudo curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
sudo echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get install -y unzip xvfb libxi6 libgconf-2-4 default-jdk google-chrome-stable

wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
unzip chromedriver_linux64.zip

sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver

# wget https://selenium-release.storage.googleapis.com/3.13/selenium-server-standalone-3.13.0.jar

wget -O /var/www/selenium.jar https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar