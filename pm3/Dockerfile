FROM interlegis/plone
MAINTAINER "Fabio Rauber" <fabiorauber@gmail.com>

RUN apt-get install -y \
     libldap2-dev \
     libsasl2-dev \
     libbz2-dev \
     libreadline6-dev \
     readline-common \
     python-imaging \
     python-docutils \
     python-psycopg2 \
     xlhtml \
     xpdf \
     xsltproc \
     ppthtml \
     pdftohtml \
     poppler-utils \
     wv \
     unzip \
     lynx \
     links \
     elinks

COPY src/versions.cfg       $ZOPE_HOME/
COPY src/pm3.cfg            $ZOPE_HOME/
COPY src/base.cfg           $ZOPE_HOME/

RUN ./install.sh
