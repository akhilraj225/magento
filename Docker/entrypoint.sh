#!/bin/bash
eval $(printenv | awk -F= '{print "export " "\""$1"\"""=""\""$2"\"" }' >> /etc/profile);
cp -f /app/default /etc/nginx/sites-available/default

supervisord -c /etc/supervisor.conf

# Cleanup
rm -fr /app/.git;
apt remove -y git;
apt clean;
apt -s clean;
apt clean all;
apt autoremove -y;
apt-get clean;
apt-get -s clean;
apt-get clean all;
apt-get autoclean;
