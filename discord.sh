#!/bin/bash

log() { echo "[discord.sh] $@" ; }

# Set defaults for all variables
export DISCORD_BOT_TOKEN=${DISCORD_BOT_TOKEN:-}
export DISCORD_BOT_PREFIX=${DISCORD_BOT_PREFIX:-/}
export DISCORD_PORT=${DISCORD_PORT:-8080}
export DISCORD_CHANNEL_ID=${DISCORD_CHANNEL_ID:-}
export DISCORD_ALLOW_LOGINS=${DISCORD_ALLOW_LOGINS:-true}
export DISCORD_CLEAN_INVITES=${DISCORD_CLEAN_INVITES:-true}
export DISCORD_USE_NICKNAMES=${DISCORD_USE_NICKNAMES:-true}

__configure() {
    env | grep ^DISCORD_ | cut -f 1 -d= | while read e ; do
        log "Configuring '$e' in '$1' ..."
        sed -e "s/\$($e)/${!e}/g" -i "$1"
    done
}

__configure /var/lib/discordmt/relay.conf

log "Starting discord bridge"
/var/lib/discordmt/server.py

