#!/bin/sh

echo Your studio will be available shortly: $LAGOON_ROUTE

if [ ! -z "$LAGOON_ENVIRONMENT_TYPE" ]; then
	echo "$LAGOON_ENVIRONMENT_TYPE: Sanity is starting"
	npm run start | tee /tmp/sanity.log
else
	echo "Local: Sanity is starting"
	npm run dev | tee /tmp/sanity.log
fi
