# add user
useradd -ms /bin/bash developer
adduser developer sudo

# allow writing
usermod -G developer www-data
usermod -a -G www-data developer