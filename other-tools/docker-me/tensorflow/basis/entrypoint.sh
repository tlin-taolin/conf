#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}
USER_NAME=lin

echo "Starting with UID : $USER_ID"
useradd --create-home --shell /bin/bash -u $USER_ID -o -c "" -m ${USER_NAME}

echo "${USER_NAME}:${USER_NAME}" | chpasswd
usermod -aG sudo,adm ${USER_NAME}
exec /usr/local/bin/gosu ${USER_NAME} "$@"
