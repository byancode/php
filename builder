#!/bin/bash

VERSIONS=('8.2.3')

for VERSION in "${VERSIONS[@]}"; do
    echo "Building PHP ${VERSION}...";
    docker compose build --build-arg "PHP_VERSION=${VERSION}";
    docker tag byancode/php:swoole byancode/php:${VERSION}-swoole;
    docker tag byancode/php:fpm byancode/php:${VERSION}-fpm;
    docker tag byancode/php byancode/php:${VERSION};

    SHORT_VERSION=$(echo "${VERSION}" | cut -d "." -f 1,2);

    docker tag byancode/php:swoole byancode/php:${SHORT_VERSION}-swoole;
    docker tag byancode/php:fpm byancode/php:${SHORT_VERSION}-fpm;
    docker tag byancode/php byancode/php:${SHORT_VERSION};

    docker push byancode/php:${VERSION}-swoole;
    docker push byancode/php:${VERSION}-fpm;
    docker push byancode/php:${VERSION};

    docker push byancode/php:${SHORT_VERSION}-swoole;
    docker push byancode/php:${SHORT_VERSION}-fpm;
    docker push byancode/php:${SHORT_VERSION};
done

docker compose push;