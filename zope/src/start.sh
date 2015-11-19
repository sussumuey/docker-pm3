#!/bin/bash

_terminate() {
  $ZOPE_HOME/bin/instance stop
  kill -TERM $child 2>/dev/null
}

trap _terminate SIGTERM SIGINT

LAST_CFG=`bin/develop rb -n`
echo $LAST_CFG

# Avoid running buildout on docker start
if [[ "$LAST_CFG" == *base.cfg ]]; then
  if ! test -e $ZOPE_HOME/buildout.cfg; then
      python /configure.py
  fi

  if test -e $ZOPE_HOME/buildout.cfg; then
      $ZOPE_HOME/bin/buildout -c $ZOPE_HOME/buildout.cfg
  fi
fi

chown -R 500:500 $ZOPE_HOME/var $ZOPE_HOME/parts

$ZOPE_HOME/bin/instance start
$ZOPE_HOME/bin/instance logtail &

child=$!
wait "$child"
