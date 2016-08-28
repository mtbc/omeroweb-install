#!/bin/bash

set -e -u -x

OMERO_USER=${OMERO_USER:-}

set +u
source $(eval echo ~"${OMERO_USER}")/omerowebvenv/bin/activate
set -u

pip install django-redis-cache>=1.6.5

# Register the app
$(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'
$(eval echo ~"${OMERO_USER}")/OMERO.py/bin/omero config set omero.web.caches '{"default": {"BACKEND": "redis_cache.RedisCache","LOCATION": "127.0.0.1:6379"}}'