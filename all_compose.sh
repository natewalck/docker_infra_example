#!/bin/bash
# This is a simple script to run docker-compose on the target directory and each project with the
# correct set of override files. Set CLOUD_ENV to the override file you want to
# use, and the first argument to this program is the project to run in.
# Everything else is passed to docker-compose.
# Warning: docker-compose can't handle DOCKER_HOST=ssh://<profile>
ls -d -- */| grep -Ev 'traefik' | grep -Ev 'example'| grep -Ev 'not_used' | while read i; do ./compose.sh "$i" "$@" ; done;

./compose.sh traefik $@
