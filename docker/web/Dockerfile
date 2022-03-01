FROM thecodingmachine/php:7.4-v4-slim-apache

USER root

RUN apt-get update
RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/bcmath/ && ./install.sh
RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/gd/ && ./install.sh
RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/intl/ && ./install.sh
#RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/mcrypt/ && ./install.sh
RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/pdo_mysql/ && ./install.sh
RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/soap/ && ./install.sh
#RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/xsl/ && ./install.sh
#RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/zip/ && ./install.sh
RUN cd /usr/local/lib/thecodingmachine-php/extensions/current/xdebug/ && ./install.sh

#RUN sudo apt-get install php-xdebug -y

RUN sudo apt autoremove && sudo apt autoclean
RUN sudo apt update
RUN sudo apt install nodejs -y
RUN sudo apt install libssl1.1=1.1.1f-1ubuntu2 -y --allow-downgrades
RUN sudo apt install npm -y
RUN npm install -g grunt-cli -y
RUN npm install -y
RUN npm update -y
RUN sudo apt-get install lsof
RUN npm install --global gulp-cli
RUN sudo apt install mlocate
RUN sudo apt-get update
RUN sudo apt-get install apache2-utils -y
RUN sudo apt-get install net-tools
RUN sudo apt-get install telnet
RUN sudo apt-get install rsyslog -y
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install postfix -y
RUN sudo apt-get update && apt-get install -y lsb-release && apt-get clean all

USER docker

ENV PHP_EXTENSION_BCMATH=1 \
    PHP_EXTENSION_GD=1 \
    PHP_EXTENSION_INTL=1 \
    PHP_EXTENSION_MCRYPT=1 \
    PHP_EXTENSION_PDO_MYSQL=1 \
    PHP_EXTENSION_SOAP=1 \
    PHP_EXTENSION_XSL=1 \
    PHP_EXTENSION_ZIP=1 \
    PHP_INI_MEMORY_LIMIT=-1 \
    PHP_INI_ERROR_REPORTING=E_ALL \
    PHP_INI_MAX_INPUT_VARS=200000000000 \
    PHP_INI_MAX_INPUT_TIME=600000000 \
    PHP_INI_MAX_INPUT_NESTING_LEVEL=258000000 \
    PHP_INI_MAX_EXECUTION_TIME=18000000000 \
    PHP_INI_POST_MAX_SIZE=100G

USER root

ENV APACHE_EXTENSIONS "rewrite headers ssl socache_shmcb"

EXPOSE 80
EXPOSE 443
EXPOSE 9200
