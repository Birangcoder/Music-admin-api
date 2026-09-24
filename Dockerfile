FROM php:8.3-cli

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-install curl mysqli pdo_mysql zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

COPY docker/php.ini /usr/local/etc/php/conf.d/99-music-admin.ini

COPY . .

EXPOSE 10000

CMD ["sh", "-c", "php -S 0.0.0.0:${PORT:-10000} -t /var/www"]