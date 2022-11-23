#!/bin/bash

echo "Running Dovecot"
sudo chmod 0777 /srv/vmail
sudo dovecot -F
exec "$@"
