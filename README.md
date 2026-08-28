# Moodle LMS Dockerized

A simple Dockerized setup for running Moodle LMS locally.

## Host Dependencies

Before running, ensure your system has the following installed:

- [Docker or Podman]
- [Docker Compose or Podman Compose]

## Setup and Run

```bash
# 1. Clone the repository

git clone --branch=podman-native https://github.com/edgarroncero/moodle-lms-dockerized.git
cd moodle-lms-dockerized

# 2. Pull and build PHP-FPM image.

docker image pull docker.io/library/php:8.3-apache-trixie
docker compose pull
docker compose build

# 3. Copy/edit the .env file and start all containers

cp .env.template .env
docker compose up -d
