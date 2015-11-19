FROM ubuntu:14.04
MAINTAINER "Fabio Rauber" <fabiorauber@gmail.com>

ENV ZEO_HOME=/srv/plone/zeo-server

# Upgrade Ubuntu
RUN apt-get update && apt-get upgrade

RUN apt-get install -y \
        git \
        puppet \
        language-pack-pt-base && \
# Avoid errors in Puppet Service evaluation
    mv /sbin/initctl /sbin/oldinitctl && \
    echo -e '#!/bin/bash\nif [ $1 == "--version" ]\nthen\n  echo "initctl (upstart 1.12.1)"\nfi\n/sbin/oldinitctl "$@"' > /sbin/initctl && \
    chmod 755 /sbin/initctl && \
# Continue...
    git clone https://github.com/interlegis/pm3-puppet-installer.git /root/pm3-puppet-installer && \
    cd /root/pm3-puppet-installer && \
    ./install.sh -z -y && \
    rm /srv/plone/buildout-cache.tar.gz

COPY src/start.sh /usr/bin/start

VOLUME /srv/plone/zeo-server/var/

USER plone_daemon

EXPOSE 2500

CMD ["/usr/bin/start"] 
