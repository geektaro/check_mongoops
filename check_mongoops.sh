#!/bin/bash
# Nagios return codes
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
costs=`mongo 192.168.10.3/jiepang_production --eval 'printjson(db.currentOp())' |grep secs_running |grep -Po '"secs_running" : \K[0-9]+'`;
echo -n "OK - secs_running: "${costs}
for cost in $costs; do
	if [ $cost -gt 30 ]; then
        echo "CRITICAL - secs_running: "${cost}
		exit $STATE_CRITICAL
	elif [ $cost -gt 10 ]; then
        echo "WARNING - secs_running: "${cost}
		exit $STATE_WARNING
	fi
done
exit $STATE_OK
