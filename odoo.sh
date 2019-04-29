#!/usr/bin/env bash

docker run -d -p 8069:8069 --name odooweb --link dbweb:db  \
    --mount type=bind,source=/home/st/Desktop/DARF-ANGeles/addons11,target=/mnt/extra-addons \
    --mount type=bind,source=/home/st/Desktop/DARF-ANGeles/filestore,target=/var/lib/odoo/filestore \
     -t odooweb1
