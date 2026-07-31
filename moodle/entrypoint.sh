#!/bin/sh

set -eu

if [ ! -f /var/www/html/version.php ]; then
    echo "Initializing Moodle..."

    cp -a /usr/src/moodle/. /var/www/html/

    if [ -f /build/config.php ]; then
        cp /build/config.php /var/www/html/config.php
    fi

    chown -R www-data:www-data /var/www/html
fi

mkdir -p /var/local/moodledata
chown -R www-data:www-data /var/local/moodledata

exec "$@"
