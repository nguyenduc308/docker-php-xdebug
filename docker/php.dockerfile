FROM php:8.0.0-fpm
COPY ./etc/php/php.ini $PHP_INI_DIR/
COPY ./etc/php/xdebug.ini $PHP_INI_DIR/conf.d/

RUN cd ~
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN ln -s /usr/local/bin/composer /usr/bin/composer

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libzip-dev \
    libicu-dev


# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql zip
RUN docker-php-ext-install gd
RUN docker-php-ext-install intl 

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

