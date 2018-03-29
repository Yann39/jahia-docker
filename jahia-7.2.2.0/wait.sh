#!/bin/sh

# Wait until MySQL is ready
while ! exec 6<>/dev/tcp/mysql/3306; do
    echo "Trying to connect to MySQL at 3306..."
    sleep 5
done