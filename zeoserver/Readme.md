## Zeoserver ready to run Docker image

Docker image for ZEO server with `plone.recipe.zeoserver` full support
(supports all plone.recipe.zeoserver options as docker environment variables).

Note: This image is a port from eeacms/zeoserver to run from an Ubuntu base image. Thanks to EEA for the original code.

### Supported tags and respective Dockerfile links

  -  `:latest` (default)


### Base docker image

 - [hub.docker.com](https://registry.hub.docker.com/u/eeacms/zeoserver)


### Source code

  - [github.com](http://github.com/eea/eea.docker.zeoserver)


### Installation

1. Install [Docker](https://www.docker.com/).


## Usage

Most of the configuration of this image is based on the 
[plone.recipe.zeoserver](https://pypi.python.org/pypi/plone.recipe.zeoserver)
recipe package so it is advised that you check it out.

### Run with basic configuration

    $ docker run eeacms/zeoserver

The image is built using a bare `buildout.cfg` file:

    [buildout]
    extends = http://dist.plone.org/release/4.3.6/versions.cfg
    parts = zeoserver

    [versions]
    zc.buildout = 2.2.1
    setuptools = 7.0

    [zeoserver]
    recipe = plone.recipe.zeoserver

`zeoserver` will therefore run inside the container with the default parameters given
by the recipe, such as listening on `port 8100`.

### Extend configuration through environment variables

Environment variables can be supplied either via an `env_file` with the `--env-file` flag
    
    $ docker run --env-file zeoserver.env eeacms/zeoserver

or via the `--env` flag

    $ docker run --env BUILDOUT_ZEO_ADDRESS="80" eeacms/zeoserver

It is **very important** to know that the environment variables supplied are translated
into buildout configuration. For each variable with the prefix `BUILDOUT_` there will be
a line added to the `[zeoserver]` configuration. For example, if you want to set the
`read-only` attribute to the value `true`, you have to supply an environment variable
in the form `BUILDOUT_READ_ONLY="true"`. When the environment variable is processed,
the prefix is striped, `_` turns to `-` and uppercase turns to lowercase. Also, if the
value is enclosed in quotes or apostrophes, they will be striped. The configuration will
look like

    [zeoserver]
    ...
    read-only = true
    ...

The variables supported are the ones supported by the [recipe](https://pypi.python.org/pypi/plone.recipe.zeoserver),
so check out its documentation for a full list. Keep in mind that this option will trigger
a rebuild at start and might cause a few seconds of delay.

### Use a custom configuration file mounted as a volume

    $ docker run -v /host/path/to/buildout.cfg:/opt/zeoserver/buildout.cfg eeacms/zeoserver

You are able to start a container with your custom `buildout` configuration with the mention
that it must be mounted at `/opt/zeoserver/buildout.cfg` inside the container. Keep in mind
that this option will trigger a rebuild at start and might cause delay, based on your
configuration. It is unadvised to use this option to install many packages, because they will
have to be reinstalled every time a container is created.


### Extend the image with a custom configuration file

Additionally, in case you need to considerably change the base configuration of this image,
you can extend it with your configuration. You can write Dockerfile like this

    FROM eeacms/zeoserver

    COPY custom.cfg /opt/zeoserver/base.cfg
    RUN bin/buildout -c base.cfg

and then run

   $ docker build -t zeoserver:custom .

## Persistent data as you wish

For production use, in order to avoid data loss we advise you to keep your Data.fs and blobs within
a [data-only container](https://medium.com/@ramangupta/why-docker-data-containers-are-good-589b3c6c749e).
The `data` container keeps the persistent data for a production environment and must be backed up.
If you are running in a devel environment, you can skip the backup and delete the container if you want.

If you have a Data.fs file for your application, you can add it to the `data` container with the following
command:

    $ docker run --rm \
        --volumes-from my_data_container \
        --volume /host/path/to/Data.fs:/restore:ro \
        busybox \
          /bin/sh -c "cp /restore/Data.fs /opt/zeoserver/var/filestorage/ && \
          chown -R 500:500 /opt/zeoserver/var/filestorage"

The command above creates a bare `busybox` container using the persistent volumes of your data container.
The parent directory of the `Data.fs` file is mounted as a `read-only` volume in `/mnt`, from where the
`Data.fs` file is copied to the filestorage directory you are going to use (default `/opt/zeoserver/var/filestorage`).
The `data` container must have this directory marked as a volume, so it can be used by the `zeoserver` container,
with a command like:

    $ docker run --volumes-from my_data_container eeacms/zeoserver

The volumes from the `data` container will overwrite the contents of the directories inside the `zeoserver`
container, in a similar way in which the `mount` command works. So, for example, if your data container
has `/opt/zeoserver/var/filestorage` marked as a volume, running the above command will overwrite the
contents of that folder in the `zeoserver` with whatever there is in the `data` container.

The data container can also be easily [copied, moved and be reused between different environments](https://docs.docker.com/userguide/dockervolumes/#backup-restore-or-migrate-data-volumes).

### Docker-compose example

A `docker-compose.yml` file for `zeoserver` using a `data` container:

    zeoserver:
      image: eeacms/zeoserver
      volumes_from:
      - data

    data:
      image: busybox
      volumes:
      - /opt/zeoserver/var/filestorage
      - /opt/zeoserver/var/blobstorage
      command: chown -R 500:500 /opt/zeoserver/var

## Upgrade

    $ docker pull eeacms/zeoserver


## Supported environment variables ##

As mentioned above, the supported environment variables are derived from the configuration options
from the [recipe](https://pypi.python.org/pypi/plone.recipe.zeoserver). For example, `read-only`
becomes `BUILDOUT_READ_ONLY` and `zeo-address` becomes `BUILDOUT_ZEO_ADDRESS`.

For variables that support a list of values (such as `eggs`, for example), separe them by space, as
in `BUILDOUT_EGGS="zc.async ZopeUndo"`.

Besides the variables supported by the `zeoserver` recipe, you can also use `INDEX` and `FIND_LINKS`
that extend the `[buildout]` tag.

## Copyright and license

The Initial Owner of the Original Code is European Environment Agency (EEA).
All Rights Reserved.

The Original Code is free software;
you can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later
version.


## Funding

[European Environment Agency (EU)](http://eea.europa.eu)
