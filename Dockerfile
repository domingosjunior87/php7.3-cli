FROM domingosjunior87/php7.3:latest

RUN apt-get update \
    && apt-get -y --no-install-recommends install apt-utils openssh-client rsync curl \
	wget zip git 

# Configure SSH
RUN which ssh-agent || ( apt-get update -y && apt-get install openssh-client -y ) \
    && mkdir -p ~/.ssh

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Install XDebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug