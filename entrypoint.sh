#!/bin/bash
set -e

echo "TSUNG_WORKSPACE = $TSUNG_WORKSPACE"
echo "TSUNG_CONFIG_FILE = $TSUNG_CONFIG_FILE"

if [ ! -d "$TSUNG_WORKSPACE" ]; then
	echo >&2 'error: tsung workspace not found ! '
	exit 1
fi

if [ ! -f "$TSUNG_WORKSPACE/$TSUNG_CONFIG_FILE" ]; then
	echo >&2 'error: tsung config file not found ! '
	exit 1
fi

service ssh start
tsung -f $TSUNG_WORKSPACE/$TSUNG_CONFIG_FILE -k start
