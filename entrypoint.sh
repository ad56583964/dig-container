#!/bin/bash
rsync -av /home/user/container-temp/* /home/user/workdir/

echo "entrypoint.sh finish"

exec "$@"