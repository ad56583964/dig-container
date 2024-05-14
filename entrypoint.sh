#!/bin/bash
mv /home/user/container-temp/* /home/user/workdir/

echo "entrypoint.sh finish"

exec "$@"