#!/usr/bin/env bash
cd /var/www

chmod -R 777 storage

/usr/local/bin/composer.phar install

/sbin/my_init
