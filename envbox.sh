#!/bin/bash

TOPDIR=$(dirname $0)

docker run --it -n envbox \
--network host \
-v ${TOPDIR}/workdir:/home/user/workdir
-v 

