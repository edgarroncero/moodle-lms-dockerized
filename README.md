# Moodle LMS Dockerized

A simple Dockerized setup for running Moodle LMS locally.

## Host Dependencies

Before running, ensure your system has the following installed:

- [OpenSSL](https://www.openssl.org/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Setup and Run

1. **Clone the repository**  

```bash
git clone https://github.com/edgarroncero/moodle-lms-dockerized.git
cd moodle-lms-dockerized

2. **Download Moodle**

cd volumes
wget https://packaging.moodle.org/stable405/moodle-latest-405.tgz
tar -xvpf moodle-latest-405.tgz
chmod -R 777 moodle
cd ..

2. **Build PHP-FPM container**

docker compose build php-fpm

4. **Initialize environment**

sh init.sh

5. **Start all containers**

docker compose up -d

