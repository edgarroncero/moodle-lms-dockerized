FROM docker.io/library/php:8.3-apache-trixie

# Install system packages
RUN apt-get update && apt-get install -y \
    libldap2-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libzip-dev \
    libpq-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libsodium-dev \
    ghostscript \
    python3 \
    graphviz \
    aspell \
    poppler-utils \
    locales \
    locales-all \
    git \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure ldap

RUN docker-php-ext-install -j"$(nproc)" \
    exif \
    curl \
    gd \
    intl \
    ldap \
    mbstring \
    mysqli \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    soap \
    xml \
    zip \
    opcache

# Apache on port 8080
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
 && sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf

EXPOSE 8080

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# PHP configuration
COPY php.ini /usr/local/etc/php/php.ini

# Keep config.php outside the webroot until first startup
COPY config.php /build/config.php

# Download Moodle into the image
RUN mkdir -p /usr/src/moodle \
 && curl -L https://packaging.moodle.org/stable405/moodle-latest-405.tgz \
    | tar -xz -C /usr/src/moodle --strip-components=1

# Runtime directories
RUN mkdir -p \
      /var/www/html \
      /var/local/moodledata \
 && chown -R www-data:www-data \
      /usr/src/moodle \
      /var/www/html \
      /var/local/moodledata

# Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]
