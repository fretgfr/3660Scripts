#!/bin/bash
i="0"
echo "      date     time $(free -m | grep total | sed -E 's/^    (.*)/\1/g')" >> /home/randomman02x/memUse.log 2>&1
while [ $i -lt 20 ]
do
    echo "$(date '+%Y-%m-%d %H:%M:%S') $(free -m | grep Mem: | sed 's/Mem://g')" >> /home/randomman02x/memUse.log 2>&1
    sleep 1
i=$[$i+1]
done
