FROM php:8.2-apache

# Copy your site files in
COPY . /var/www/html/

# Enable common extensions (add/remove as your app needs)
RUN docker-php-ext-install mysqli pdo pdo_mysql

EXPOSE 80