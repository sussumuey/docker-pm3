#!/bin/bash

_terminate() {
	$ZEO_HOME/bin/zeoserver stop
	kill -TERM $child 2>/dev/null
}

trap _terminate SIGTERM SIGINT

if ! test -e $ZEO_HOME/buildout.cfg; then
    python /configure.py
fi

if test -e $ZEO_HOME/buildout.cfg; then
    $ZEO_HOME/bin/buildout -c $ZEO_HOME/buildout.cfg
fi

$ZEO_HOME/bin/zeoserver start
$ZEO_HOME/bin/zeoserver logtail &

child=$!
wait "$child"
