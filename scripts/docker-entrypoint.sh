#!/bin/bash
set -e

LOCAL_IP=$(hostname -I | awk '{print $1}')

case $1 in
    master)
        tail -f /dev/null
        ;;
    server)
        $JMETER_HOME/bin/jmeter-server \
            -Jserver.rmi.ssl.disable=true \
            -Dserver.rmi.localport=${SERVER_RMI_LOCALPORT} \
            -Dserver_port=${SERVER_PORT} \
            -Djava.rmi.server.hostname=${LOCAL_IP}
        ;;
    *)
        echo "Sorry, this option doesn't exist!"
        ;;
esac

exec "$@"
