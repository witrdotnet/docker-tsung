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

echo "start ssh..."
service ssh start

cd $TSUNG_WORKSPACE
if ls $TSUNG_WORKSPACE/*.erl 1> /dev/null 2>&1; then
	echo "compile erlang scripts..."
	erlc $TSUNG_WORKSPACE/*.erl
	echo "compile erlang scripts OK"
fi

if ls $TSUNG_WORKSPACE/*.beam 1> /dev/null 2>&1; then
	echo "copy beam scripts..."
	cp $TSUNG_WORKSPACE/*.beam /usr/lib/erlang/lib/tsung-1.6.0/ebin/
fi

echo "run tsung..."
tsung -f $TSUNG_WORKSPACE/$TSUNG_CONFIG_FILE -k start
