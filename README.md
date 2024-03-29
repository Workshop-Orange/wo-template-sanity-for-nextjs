# Workshop Orange Template Sanity for NextJS

This project is the Sanity.io Template for the NextJS project at https://github.com/Workshop-Orange/wo-template-nextjs-for-sanity.

The project can (but does not require) deploy the studio to amazee.io

## Getting Started With amazee.io Pygmy (Development Mode)

Prerequiste: Make sure [Pygmy](https://docs.lagoon.sh/using-lagoon-the-basics/local-development-environments/) is installed.

If Pygmy is installed, create the `.env.local` from the example, and build the container. By default this will be in development mode, so no `npm build` will be run.

```bash
copy .env.example .env.local
docker-compose build --force-rm --no-cache
```

Next, install node dependencies for local development. Even though `npm install` is run as part of the container build, this needs to be run by `docker-compose run` because `docker-compose up` will mount you local directory OVER the container's /app directory.

```bash
docker-compose run node npm install
```

Finally, run the container
```bash
docker-compose up
```

Open [http://wo-template-sanity-for-nextjs.docker.amazee.io](http://wo-template-sanity-for-nextjs.docker.amazee.io) with your browser to see the result.
You can alter the URL to match your project by editing `LAGOON_ROUTE` in docker-compose.yml

## Getting Started With amazee.io Pygmy (Simulate Production)
Prerequiste: Make sure [Pygmy](https://docs.lagoon.sh/using-lagoon-the-basics/local-development-environments/) is installed.

If Pygmy is installed, create the `.env.local` from the example, and build the container. By adding a build argument we will simulate production mode, so `npm build` will be run.

```bash
cp .env.example .env.local
docker-compose build --no-cache --force-rm --build-arg LAGOON_ENVIRONMENT_TYPE=production
```

Next, edit the `.env.local` and change `LAGOON_ENVIRONMENT_TYPE` from `development` to `production`.

Once you have change `LAGOON_ENVIRONMENT_TYPE` to `production`, install node dependencies for local development, and build the production build. Even though `npm install` and `npm run build` are run as part of the container build, they need to be run by again because `docker-compose up` will mount your local directory OVER the container's /app directory.

```bash
docker-compose run node npm install
docker-compose run node npm run build
```

Finally, run the container
```bash
docker-compose up
```

Open [http://wo-template-sanity-for-nextjs.docker.amazee.io](http://wo-template-sanity-for-nextjs.docker.amazee.io) with your browser to see the result.
You can alter the URL to match your project by editing `LAGOON_ROUTE` in docker-compose.yml
