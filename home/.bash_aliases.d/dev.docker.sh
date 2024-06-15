#!/bin/bash
#
# Edit this to your liking, this is what we use to push to a local docker reg
# that has no TLS layer.
#

export DOCKER_OPTS="--insecure-registry barnowl:5000"

# A better global approach is to edit the /etc/docker/daemon.json file on
# your server and add a section like this:
#
# {
#  "insecure-registries": ["gitlab.mycompany.com:4567"]
# }
