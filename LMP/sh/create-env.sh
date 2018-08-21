#!/usr/bin/env bash

source /tmp/rvm.sh
echo "NETWORKING=yes" > /etc/sysconfig/network
cat /tmp/nginx.conf > /etc/nginx/nginx.conf


chkconfig --level 2345 redis on
chkconfig --level 2345 nginx on

#service nginx start
#service redis start
