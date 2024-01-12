#!/bin/sh

echo Your studio will be available shortly: $LAGOON_ROUTE

echo "$LAGOON_ENVIRONMENT_TYPE: NextJS is starting"

if [ "$LAGOON_ENVIRONMENT_TYPE" == "production" ]; then
	npm run start | tee /tmp/sanity.log
else
	npm run dev | tee /tmp/sanity.log
fi
