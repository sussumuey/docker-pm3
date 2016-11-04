FROM interlegis/plone
MAINTAINER "Sussumu Yamada" <sussumu@interlegis.leg.br>

RUN apt-get install -y \
     build-essential \
     zlib1g-dev \
     libjpeg62-dev \
     libssl-dev \
     libxml2-dev \
     libxslt1-dev \
     libldap2-dev \
     libsasl2-dev \
     libfreetype6-dev \
     libbz2-dev \
     libreadline-dev \
     libreadline6-dev \
     readline-common \
     python-dev \
     python-imaging \
     python-ldap \
     python-setuptools \
     python-virtualenv \
     python-docutils \
     python-psycopg2 \
     python-libxml2 \
     xpdf \
     xsltproc \
     poppler-utils \
     wv \
     unzip \
     lynx \
     links \
     elinks \
     git \
     xlhtml \
     ppthtml \
     pdftohtml \

COPY src/versions.cfg       $ZOPE_HOME/
COPY src/pm3.cfg            $ZOPE_HOME/
COPY src/base.cfg           $ZOPE_HOME/

RUN ./install.sh
