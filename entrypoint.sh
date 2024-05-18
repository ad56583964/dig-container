#!/bin/bash
rsync -av /home/user/container-temp/* /home/user/archive/

echo "entrypoint.sh finish"

exec "$@"