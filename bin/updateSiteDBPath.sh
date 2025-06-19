#!/bin/bash

CATALINA_BASE=$(pwd)
CATALINA_BASE="${CATALINA_BASE%/bin}"
FILE="../webapps/site/src/incl/const.incl"

sed -i "s|DB_DIR.*|DB_DIR = \"${CATALINA_BASE}/webapps/site/db/\";|" "${FILE}"
