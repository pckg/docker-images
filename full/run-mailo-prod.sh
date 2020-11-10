echo "Running all mailo services"

echo "Starting queue"

sudo docker run -d --restart=unless-stopped --hostname=queue.mailo.impero.local --name=queue.mailo.impero.local \
-m=1G \
--network=mailo-backend -p=5672:5672 rabbitmq:3-alpine

echo "Queue started"

echo "Running web on zero"

sudo docker run -d --restart=unless-stopped --hostname web.mailo.impero.local --name web.mailo.impero.local \
-v /www/gnpdev/mailo.foobar.si/htdocs/:/var/www/html/ \
-v /mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/:/mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/ \
-v /home/impero/impero/mounts/web.mailo/.env:/var/www/html/.env \
-v /www/gnpdev/mailo.foobar.si/ssl/fullchain.pem:/etc/ssl/certs/apache-selfsigned.crt \
-v /www/gnpdev/mailo.foobar.si/ssl/privkey.pem:/etc/ssl/private/apache-selfsigned.key \
-p=8090:443 \
-m=1G \
--network=mailo-backend schtr4jh/private:apache

echo "Web started"

echo "Running web on one"

sudo docker run -d --restart=unless-stopped --hostname web.mailo.impero.local --name web.mailo.impero.local \
-v /www/gnpdev/mailo.foobar.si/htdocs/:/var/www/html/ \
-v /mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/:/mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/ \
-v /home/impero/impero/mounts/zero.sendmail-worker.mailo/.env:/var/www/html/.env \
-v /www/gnpdev/mailo.foobar.si/ssl/fullchain.pem:/etc/ssl/certs/apache-selfsigned.crt \
-v /www/gnpdev/mailo.foobar.si/ssl/privkey.pem:/etc/ssl/private/apache-selfsigned.key \
-p=8091:443 \
-m=1G \
--network=mailo-backend schtr4jh/private:apache

echo "Web started"

echo "Running web on two"

sudo docker run -d --restart=unless-stopped --hostname web.mailo.impero.local --name two.web.mailo.impero.local \
-v /www/gnpdev/mailo.foobar.si/htdocs/:/var/www/html/ \
-v /mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/:/mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/ \
-v /home/impero/impero/mounts/two.web.mailo/.env:/var/www/html/.env \
-v /mnt/volume-fra1-01/letsencrypt/live/mailo.foobar.si/fullchain.pem:/etc/ssl/certs/apache-selfsigned.crt \
-v /mnt/volume-fra1-01/letsencrypt/live/mailo.foobar.si/privkey.pem:/etc/ssl/private/apache-selfsigned.key \
-p=8092:443 \
-m=1G \
--network=mailo-backend schtr4jh/private:apache

echo "Web started"

#echo "Running cron"

#sudo docker run -d --restart=unless-stopped --hostname cron.mailo.impero.local --name cron.mailo.impero.local \
#-v /www/gnpdev/mailo.foobar.si/htdocs/:/var/www/html/ \
#-v /home/impero/impero/mounts/cron-mailo/:/some/logs/ \
#--network=mailo-backend schtr4jh/private:php-cron

#echo "Cron started"

echo "Running sendmail worker with set hostname"

sudo docker run -d --restart=unless-stopped --hostname zero.gonparty.eu --name zero.sendmail-worker.mailo.impero.local \
-v /www/gnpdev/mailo.foobar.si/htdocs/:/var/www/html/ \
-v /mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/:/mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/ \
-v /home/impero/impero/mounts/zero.sendmail-worker.mailo/.env:/var/www/html/.env \
-v /etc/opendkim/:/etc/opendkim/ \
-e JOB="console mailo mailo:send-mail-worker --type=newsletter" \
-e DOMAIN="zero.gonparty.eu" \
-m=1G \
--network=mailo-backend schtr4jh/private:sendmail-php

echo "Sendmail worker started"

echo "Running sendmail worker 2 with set hostname"

sudo docker run -d --restart=unless-stopped --hostname one.gonparty.eu --name sendmail-worker.mailo.impero.local \
-v /www/gnpdev/mailo.foobar.si/htdocs/:/var/www/html/ \
-v /mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/:/mnt/volume-fra1-01/live/gnpdev/mailo.foobar.si/storage/private/ \
-v /etc/opendkim/:/etc/opendkim/ \
-e JOB="console mailo mailo:send-mail-worker --type=transactional" \
-e DOMAIN="one.gonparty.eu" \
-m=1G \
--network=mailo-backend schtr4jh/private:sendmail-php

echo "Sendmail worker started"

echo "Starting dkim generator"

sudo docker run -d --restart=unless-stopped --hostname dkim-generator.mailo.impero.local --name dkim-generator.mailo.impero.local \
-v /www/gnpdev/mailo.foobar.si/htdocs/:/var/www/html/ \
-v /etc/opendkim/keys/:/etc/opendkim/keys/ \
-e JOB="console mailo mailo:register-dkim-worker" \
-e DOMAIN="one.gonparty.eu" \
-m=1G \
--network=mailo-backend schtr4jh/private:sendmail-php

echo "Dkim generator started"

echo "All mailo services started"