#!/bin/bash
#set -x
while true; do
        sleep 3
        if ambari-server status | grep '^Ambari Server running$' ; then
                curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://ambari:8080/api/v1/blueprints/c1 -d "@/var/lib/ambari-server/resources/templates/blueprint.json"
                curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://ambari:8080/api/v1/clusters/c1 -d "@/var/lib/ambari-server/resources/templates/cluster.json"
                [ $? = 0 ] && exit 0
        fi
	echo 'Waiting for start Ambari Server ...'
done
