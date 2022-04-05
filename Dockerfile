
FROM php:8.0-apache

# Allow htaccess to work
RUN a2enmod rewrite

# PHP dependencies
RUN apt-get update
RUN apt-get install -y \
    curl \
    wget \
    zip \
    unzip \
    default-mysql-client

RUN docker-php-ext-install pdo_mysql

# Composer
RUN wget -O composer-setup.php https://getcomposer.org/installer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer self-update

# Point at the public directory
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN pecl install xdebug && docker-php-ext-enable xdebug
