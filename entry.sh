#!/bin/sh

set -x
set -e

if [ -z "$USER" ]; then
    USER="Anonymous"
fi

if [ -z "$GPU" ]; then
    GPU="false"
fi

if [ -z "$POWER" ]; then
    POWER="full"
fi

if [ -z "$SMP" ]; then
    SMP="true"
fi

OPTS=""
OPTS+=" --web-allow=0/0:7396"
OPTS+=" --allow=0/0:7396"
OPTS+=" --chdir=/tmp"
OPTS+=" --user=$USER"
OPTS+=" --gpu=$GPU"
OPTS+=" --power=$POWER"
OPTS+=" --smp=$SMP"

if [ -n "$PASSKEY" ]; then
    OPTS+=" --passkey=$PASSKEY"
fi

if [ -n "$TEAM" ]; then
    OPTS+=" --team=$TEAM"
fi

exec FAHClient $OPTS
