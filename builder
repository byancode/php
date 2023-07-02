#!/bin/bash

VERSIONS=('8.1.18' '8.1.19' '8.1.20' '8.2.5' '8.2.6' '8.2.7')

for VERSION in "${VERSIONS[@]}"; do
    echo "Building PHP ${VERSION}...";
    docker build --build-arg "PHP_VERSION=${VERSION}" -t byancode/php:${VERSION} .;

    MINOR_VERSION=$(echo "${VERSION}" | cut -d "." -f 1,2);
    MAJOR_VERSION=$(echo "${VERSION}" | cut -d "." -f 1);

    docker tag byancode/php:${VERSION} byancode/php:${MINOR_VERSION};
    docker tag byancode/php:${VERSION} byancode/php:${MAJOR_VERSION};

    docker push byancode/php:${VERSION};
    docker push byancode/php:${MINOR_VERSION};
    docker push byancode/php:${MAJOR_VERSION};
done

docker compose push;