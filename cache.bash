#!/bin/bash
php artisan config:clear
php artisan route:cache
php artisan cache:clear
php artisan config:cache
php artisan optimize
