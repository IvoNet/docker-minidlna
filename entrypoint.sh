#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# Remove old pid if it exists
[ -f /var/run/minidlna/minidlna.pid ] && rm -f /var/run/minidlna/minidlna.pid

for VAR in $(env); do
  if [[ "$VAR" =~ ^MINIDLNA_ ]]; then
    if [[ "$VAR" =~ ^MINIDLNA_MEDIA_DIR ]]; then
      minidlna_name='media_dir'
    else
      minidlna_name=$(echo "$VAR" | sed -r "s/MINIDLNA_(.*)=.*/\\1/g" | tr '[:upper:]' '[:lower:]')
    fi
    minidlna_value=$(echo "$VAR" | sed -r "s/.*=(.*)/\\1/g")
    echo "${minidlna_name}=${minidlna_value}" >> /etc/minidlna.conf
  fi
done

cat /etc/minidlna.conf

# Start daemon
exec /usr/sbin/minidlnad -d "$@"
