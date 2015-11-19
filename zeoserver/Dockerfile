FROM ubuntu:14.04
MAINTAINER "Fabio Rauber" <fabiorauber@gmail.com>

ENV ZEO_HOME=/opt/zeoserver

RUN apt-get update && apt-get upgrade && \
    apt-get install -y \
        python \
        python-dev && \
    apt-get clean && \
    mkdir -p $ZEO_HOME

COPY src/base.cfg           $ZEO_HOME/base.cfg
COPY src/bootstrap.py       $ZEO_HOME/
COPY src/start.sh           /usr/bin/start
COPY src/configure.py       /configure.py

WORKDIR $ZEO_HOME

RUN python bootstrap.py -v 2.2.1 --setuptools-version=7.0 -c base.cfg && \
    ./bin/buildout -c base.cfg && \
    groupadd -g 500 zope-www && \
    useradd -u 500 -g 500 -m -s /bin/bash zope-www && \
    chown -R 500:500 $ZEO_HOME

VOLUME $ZEO_HOME/var/

USER zope-www

CMD ["start"]
