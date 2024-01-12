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

RUN if [[ "$LAGOON_ENVIRONMENT_TYPE" == "production" ]]; then \
		echo "$LAGOON_ENVIRONMENT_TYPE: Running production build"; \
		npm run build; \
	else \
		echo "$LAGOON_ENVIRONMENT_TYPE: Skipping production build"; \
	fi

########################################################
# Set the command to run
########################################################
CMD ["/app/lagoon/scripts/sanity.sh"]
