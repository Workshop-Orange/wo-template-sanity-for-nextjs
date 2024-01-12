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

RUN if [[ ! -z "$LAGOON_ENVIRONMENT_TYPE" ]]; then \
		echo "$LAGOON_ENVIRONMENT_TYPE: Running production build"; \
		npm run build; \
	else \
		echo "Seems to be running locally: Skipping production build"; \
	fi

RUN mkdir /home/.config/sanity 
  && touch /home/.config/sanity/config.json
  && fix-permissions /home/.config
  && fix-permissions /home/.npm
  && fix-permissions /home/node

########################################################
# Set the command to run
########################################################
CMD ["/app/lagoon/scripts/sanity.sh"]
