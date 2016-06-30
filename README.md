# docker-pm3
Docker containers for Portal Modelo 3.0

## Requirements

### Docker

To use this image you need docker daemon installed. Run the following commands as root:

```
curl -ssl https://get.docker.com | sh
```

### Docker-compose

Docker-compose is desirable (run as root as well):

```
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
```

## Docker-compose Example

Save the following snippet as docker-compose.yaml in any folder you like, or clone this repository, which contains the same file.

```
plone:
  image: interlegis/pm3
  ports:
  - "80:80"
  links:
  - zeoserver
  environment:
  - BUILDOUT_ZEO_CLIENT=True
  - BUILDOUT_ZEO_ADDRESS=zeoserver:8100

zeoserver:
  image: interlegis/zeoserver

```

## Running

```
cd <folder where docker-compose.yaml is>
docker-compose up -d
```

## Whats happening?

To view logs on screen:

```
docker-compose logs -f
```

## Contributing

Pull requests welcome!
