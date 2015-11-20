FROM interlegis/zope
MAINTAINER "Fabio Rauber" <fabiorauber@gmail.com>

RUN apt-get install -y \
     libxml2-dev \
     libxslt1-dev

COPY src/versions.cfg       $ZOPE_HOME/
COPY src/sources.cfg        $ZOPE_HOME/
COPY src/plone.cfg          $ZOPE_HOME/
COPY src/base.cfg           $ZOPE_HOME/

RUN ./install.sh
