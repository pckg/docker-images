# mount this
mkdir /etc/opendkim
mkdir /etc/opendkim/keys

# mount this
touch /etc/opendkim/KeyTable
touch /etc/opendkim/SigningTable
touch /etc/opendkim/TrustedHosts

# simplify this to add only missing lines?
cp /usr/local/pckg-utils/external/etc_opendkim.conf /etc/opendkim.conf