#/usr/bin/env bash

docker run -i -t --rm -v "$(pwd)/cms.conf:/usr/local/etc/cms.conf:ro" --network=host brianbbsu/cms:YTP2020 /bin/bash
