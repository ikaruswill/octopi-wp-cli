FROM wordpress:cli-2.1-php7.2
# Not using ENV PHP_USER=www-data due to no env variable substitution in ADD --chown

ARG uid=1000
ARG gid=1000
USER root
RUN apk --no-cache add shadow && \
    usermod -u ${uid} www-data && \
    groupmod -g ${gid} www-data


RUN mkdir /www && \
    chown www-data:www-data /www
WORKDIR /www

ADD --chown=www-data:www-data docker-entrypoint.sh wp-config-extras.php /home/www-data/

USER www-data
ENTRYPOINT ["/home/www-data/docker-entrypoint.sh"]
CMD ["wp-restore"]
