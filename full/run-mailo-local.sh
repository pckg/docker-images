echo "Running all mailo services"

echo "Starting queue"

sudo docker run -d --restart=unless-stopped --hostname=queue.mailo.impero.local --name=queue.mailo.impero.local \
--network=mailo-backend rabbitmq:3-alpine

echo "Queue started"

echo "Running web"

sudo docker run -d --restart=unless-stopped --hostname web.mailo.impero.local --name web.mailo.impero.local \
-v /www/schtr4jh/bob.pckg.mailo/htdocs/:/var/www/html/ \
-v /home/schtr4jh/d3v/docker/pckg/full/utils/external/apache-selfsigned.crt:/etc/ssl/certs/apache-selfsigned.crt \
-v /home/schtr4jh/d3v/docker/pckg/full/utils/external/apache-selfsigned.key:/etc/ssl/private/apache-selfsigned.key \
--network=mailo-backend schtr4jh/private:apache

echo "Web started"

#echo "Running cron"

#sudo docker run -d --restart=unless-stopped --hostname cron.mailo.impero.local --name cron.mailo.impero.local \
#-v /www/schtr4jh/bob.pckg.mailo/htdocs/:/var/www/html/ \
#-v /home/impero/impero/mounts/cron-mailo/:/some/logs/ \
#--network=mailo-backend schtr4jh/private:php-cron

#echo "Cron started"

echo "Running sendmail worker"

sudo docker run -d --restart=unless-stopped --hostname sendmail-worker.mailo.impero.local --name sendmail-worker.mailo.impero.local \
-v /www/schtr4jh/bob.pckg.mailo/htdocs/:/var/www/html/ \
-e JOB="console mailo mailo:send-mail-worker --type=newsletter" \
-e DOMAIN="test.foobar.si" \
--network=mailo-backend schtr4jh/private:sendmail-php

echo "Sendmail worker started"

echo "Starting dkim generator"

sudo docker run -d --restart=unless-stopped --hostname dkim-generator.mailo.impero.local --name dkim-generator.mailo.impero.local \
-v /www/schtr4jh/bob.pckg.mailo/htdocs/:/var/www/html/ \
-e JOB="console mailo mailo:register-dkim-worker" \
-e DOMAIN="test.foobar.si" \
--network=mailo-backend schtr4jh/private:sendmail-php

echo "Dkim generator started"

echo "All mailo services started"