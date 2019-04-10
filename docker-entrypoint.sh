#!/bin/sh
set -ex

if [ $1 = 'wp-install' ]; then
    wp core download --version=$WP_VERSION

    echo "Creating wp-config.php..."
    wp config create \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=$DB_HOST \
        --extra-php < /home/www-data/wp-config-extras.php

    echo "Installing WordPress..."
    wp core install \
        --url=$SITEURL \
        --title=$BLOGNAME \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL

elif [ $1 = 'wp-upgrade' ]; then
    echo "Updating WordPress..."
    wp core update --version=$WP_VERSION
    wp core update-db

elif [ $1 = 'wp-restore' ]; then
    wp core download --version=$WP_VERSION

    echo "Creating wp-config.php..."
    wp config create \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=$DB_HOST \
        --extra-php < /home/www-data/wp-config-extras.php

    # Install missing themes and plugins
    wp plugin install $(wp plugin list --field=name) || :
    wp theme install $(wp theme list --field=name) || :
else
    exec $@
fi
