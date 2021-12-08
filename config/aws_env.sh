#! /bin/bash

s6-envdir /var/run/s6/container_environment env | grep AWS | sed -e 's/^/export /' > /config/.bash_profile