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

# Change Apache to listen on 8080
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
 && sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf

EXPOSE 8080

RUN apt-get update && apt-get install -y \
    locales \
    locales-all \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY ./php.ini /usr/local/etc/php/php.ini

# Moodle
RUN curl -L https://packaging.moodle.org/stable405/moodle-latest-405.tgz \
    | tar -xz -C /var/www/html --strip-components=1

RUN chown -R www-data:www-data /var/www/html

COPY --chown=www-data:www-data ./config.php /var/www/html

WORKDIR /var/www/html

USER www-data:www-data
