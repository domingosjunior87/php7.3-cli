FROM php:7.3.18-cli-alpine

# Adicionando libs e extensões do PHP
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
	&& apk add --no-cache openssh-client rsync unzip git curl icu-dev libxml2-dev postgresql-dev \
	&& docker-php-ext-install intl soap pdo pdo_pgsql > /dev/null \
	&& pecl install xdebug-2.9.6 \
    && docker-php-ext-enable xdebug > /dev/null \
    && apk del -f --purge .build-deps

# Instalando o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Diretório para o SSH
RUN mkdir -p ~/.ssh
