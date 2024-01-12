#!/bin/sh

echo Your studio will be available shortly: $LAGOON_ROUTE

if [ -d "/home/.config" ]; then
	fix-permissions /home/.config
fi

if [ -d "/app/.cache" ]; then
	fix-permissions /app/.cache
fi

if [ -d "/app/public" ]; then
	fix-permissions /app/public
fi

if [ ! -z "$LAGOON_ENVIRONMENT_TYPE" ]; then
	echo "$LAGOON_ENVIRONMENT_TYPE: Sanity is starting"
	npm run start | tee /tmp/sanity.log
else
	echo "Local: Sanity is starting"
	npm run dev | tee /tmp/sanity.log
fi
