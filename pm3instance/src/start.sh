#!/bin/bash

_terminate() {
  $ZOPE_HOME/bin/instance stop
  kill -TERM $child 2>/dev/null
}

trap _terminate SIGTERM SIGINT

if [ "$DBHOST" != "" ]; then
  cd /root/pm3-puppet-installer
  ./install.sh -a $DBHOST -y
fi

$ZOPE_HOME/bin/instance start
$ZOPE_HOME/bin/instance logtail &

child=$!
wait "$child"
