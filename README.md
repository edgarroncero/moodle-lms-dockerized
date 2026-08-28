# Moodle LMS Dockerized

A simple Dockerized setup for running Moodle LMS locally.

## Host Dependencies

Before running, ensure your system has the following installed:

- [Podman or Docker]
- [Podman Compose or Docker Compose]

## Setup and Run

```bash
# 1. Clone the repository

git clone --branch=main https://github.com/edgarroncero/moodle-lms-dockerized.git
cd moodle-lms-dockerized

# 2. Pull and build PHP-FPM image.

docker image pull docker.io/library/php:8.3-apache-trixie
docker compose pull
docker compose build

# 3. Copy/edit the .env file and start all containers

cp .env.template .env
docker compose up -d
```
## Run it on production behind a reverse proxy like nginx or traefik:
.env example
```bash
MOODLE_URL=https://moodle.edgarroncero.com
MOODLE_SSLPROXY=true
MOODLE_REVERSEPROXY=false
```bash
