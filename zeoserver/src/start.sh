#!/bin/bash

_terminate() {
  $ZEO_HOME/bin/zeoserver stop
  kill -TERM $child 2>/dev/null
}

trap _terminate SIGTERM SIGINT

$ZEO_HOME/bin/zeoserver start
$ZEO_HOME/bin/zeoserver logtail &

child=$!
wait "$child"
