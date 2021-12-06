#!/bin/bash
check=systemctl | grep httpd
test=$check
curDate=date +%F--%H%M
echo "Checking APACHE service status"
if [ -z "$test" ]
then
        echo $curDate
        echo "Apache is NOT running"
else
        echo $curDate
        echo "Apache is running"
        echo $check
fi
echo ""
