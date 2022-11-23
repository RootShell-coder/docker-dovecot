#!/bin/bash

echo "Running Dovecot"
sudo dovecot -F

exec "$@"
