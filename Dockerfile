FROM ubuntu:20.04
WORKDIR /app
COPY . /app
COPY Docker/BaltimoreCyberTrustRoot.crt.pem /app/
COPY Docker/entrypoint.sh /entrypoint.sh
COPY Docker/default /app/default
RUN apt-get update
# Installing Nginx PHP and modules
# ARG DEBIAN_FRONTEND=noninteractive
# ENV TZ=Asia/Qatar
# RUN apt-get install --no-install-recommends -y nginx nginx-extras
RUN apt-get install --no-install-recommends -y nginx
RUN apt-get install --no-install-recommends -y nginx-extras
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php \
    && apt-get update
RUN apt-get install -y php8.1 \
            php8.1-fpm \
            php8.1-curl \
            php8.1-mysql \
            php8.1-cgi \
            php8.1-ldap \
            php8.1-soap \
            php8.1-xsl \
            php8.1-common \
            php8.1-bz2 \
            php8.1-dba \
            php8.1-gmp \
            php8.1-gnupg \
            php8.1-http \
            php8.1-pspell \
            php8.1-tidy \
            php8.1-snmp \
            php8.1-cli \
            php8.1-gd \
            php8.1-opcache \
            php8.1-zip \
            php8.1-intl \
            php8.1-bcmath \
            php8.1-imap \
            php8.1-imagick \
            php8.1-readline \
            php8.1-memcached \
            php8.1-mbstring \
            php8.1-apcu \
            php8.1-xml \
            php8.1-dom

#Installing softwares
RUN apt-get install --no-install-recommends -y  \
    curl \
    wget \
    unzip \
    git \
    mariadb-client \
    openssh-server \
    wkhtmltopdf \
    xvfb \
    openssl \
    patch

#Nginx configuration
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;\?daemonize\s*=\s*yes/daemonize = no/g" /etc/php/8.1/fpm/php-fpm.conf
#RUN chmod -R 755 /app/web/
#Supervisor install
RUN apt-get -y install supervisor && mkdir -p /var/log/supervisor && mkdir -p /etc/supervisor/conf.d
ADD supervisor.conf /etc/supervisor.conf

EXPOSE 80 443 2222
CMD ["/bin/bash", "/entrypoint.sh"]
