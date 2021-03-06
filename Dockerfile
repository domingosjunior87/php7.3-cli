FROM php:7.3.18-cli-alpine

# Adicionando libs e extensões do PHP
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS freetype-dev libpng-dev libjpeg-turbo-dev \
	&& apk add --no-cache openssh-client rsync unzip git curl icu-dev libxml2-dev postgresql-dev freetype libpng libjpeg-turbo \
	&& docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
	&& docker-php-ext-install -j${NPROC} gd bcmath intl soap pdo pdo_pgsql > /dev/null \
	&& pecl install xdebug-2.9.6 > /dev/null \
    && docker-php-ext-enable xdebug > /dev/null \
    && apk del -f --purge .build-deps freetype-dev libpng-dev libjpeg-turbo-dev

# Instalando o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Diretório para o SSH
RUN mkdir -p ~/.ssh
