########################################################
# Start with the node builder image 
########################################################
FROM uselagoon/node-18-builder as builder

COPY package-lock.json package.json /app/
RUN npm install

########################################################
# Switch to the node runner image
########################################################
FROM uselagoon/node-18
ARG LAGOON_ENVIRONMENT_TYPE

########################################################
# Copy and build
########################################################
COPY --from=builder /app /app
COPY . /app

RUN mkdir -p /tmp/_config && fix-permissions /tmp/_config
ARG XDG_CONFIG_HOME="/tmp/_config"

RUN npm config set prefix "/tmp/_npm_config" \
  && npm config set logs-dir "/tmp/_npm_logs" \
  && npm config set cache "/tmp/_npm_cache"

RUN if [[ ! -z "$LAGOON_ENVIRONMENT_TYPE" ]]; then \
		echo "$LAGOON_ENVIRONMENT_TYPE: Running production build"; \
		npm run build; \
	else \
		echo "Seems to be running locally: Skipping production build"; \
	fi

########################################################
# Set the command to run
########################################################
CMD ["/app/lagoon/scripts/sanity.sh"]
