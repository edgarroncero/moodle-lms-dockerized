# Moodle LMS Dockerized

A simple Dockerized setup for running Moodle LMS locally.

## Host Dependencies

Before running, ensure your system has the following installed:

- [Docker or Podman]
- [Docker Compose or Podman Compose]

## Setup and Run

```bash
# 1. Clone the repository

git clone https://github.com/edgarroncero/moodle-lms-dockerized.git
cd moodle-lms-dockerized

# 2. Build PHP-FPM container

docker compose build php-fpm

# 3. Copy/edit the .env file and start all containers

cp .env.template .env
docker compose up -d
