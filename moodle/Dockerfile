FROM docker.io/library/php:8.3-apache-trixie

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
    git unzip \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure ldap

RUN docker-php-ext-install -j$(nproc) \
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

RUN apt-get update && apt-get install ghostscript python3 graphviz aspell poppler-utils -y

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY ./php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html

