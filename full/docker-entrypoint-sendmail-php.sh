#!/bin/bash
set -e

if [ -z "$JOB" ]; then
    echo "JOB env variable is required";
    exit;
fi

# apt-get install sendmail-cf m4 -y
service rsyslog start

if [ -z "$DOMAIN" ]; then
    echo "DOMAIN env variable is recommended, not setting up hosts";
    #exit;
else
  #apt-get update && apt-get install net-tools -y

  # collect variables
  #ETH0 = $(/sbin/ifconfig eth0 | awk -F ' *|:' '/inet /{print $3}')
  #ETH1 = $(/sbin/ifconfig eth1 | awk -F ' *|:' '/inet /{print $3}')

  # add requirements for sendmail
  #echo "Resolving 127.0.0.1, $ETH0 and $ETH1 as $DOMAIN"
  echo "127.0.0.1 $DOMAIN localhost.$DOMAIN localhost" > /tmp/hosts
  #echo "$ETH0 $DOMAIN localhost.$DOMAIN localhost" >> /tmp/hosts
  #echo "$ETH1 $DOMAIN localhost.$DOMAIN localhost" >> /tmp/hosts
  cat /etc/hosts >> /tmp/hosts
  cat /tmp/hosts > /etc/hosts

  # configure sendmail with dkim
  echo "Configuring sendmail"
  cp /usr/local/pckg-utils/external/etc_mail_sendmail.mc /etc/mail/sendmail.mc
  echo "" >> /etc/mail/sendmail.mc
  echo "define(\`confDOMAIN_NAME', $DOMAIN)dnl" >> /etc/mail/sendmail.mc
  echo "INPUT_MAIL_FILTER(\`opendkim', \`S=inet:8891@localhost')dnl" >> /etc/mail/sendmail.mc

  # add to mail hosts
  echo $DOMAIN >> /etc/mail/local-host-names
  echo "localhost" >> /etc/mail/local-host-names

  # rebuild sendmail config
  echo "Building sendmail config"
  m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf

fi

# restart services
echo "Restarting opendkim and sendmail"
service opendkim restart && service sendmail restart

# chown storage when existent
[ -d "/var/www/html/storage" ] && chown -R www-data:www-data /var/www/html/storage

# run the job
echo "Running with exec $JOB"
exec php /var/www/html/$JOB

# /bin/bash