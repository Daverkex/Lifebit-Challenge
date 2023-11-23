ARG REPO_EXAMPLE_PATH="servers/express/api-with-express-and-handlebars"

FROM alpine:latest AS fetcher
ARG REPO_EXAMPLE_PATH

RUN apk --no-cache add git

# Download only the app from the repo
RUN git clone --no-checkout --depth=1 --filter=tree:0 \
    https://github.com/nodejs/examples.git app && \
    cd app && \
    git sparse-checkout set --no-cone "${REPO_EXAMPLE_PATH}" && \
    git checkout

FROM node:current-alpine
ARG REPO_EXAMPLE_PATH

COPY --from=fetcher "/app/${REPO_EXAMPLE_PATH}" /app
WORKDIR app
RUN npm install
RUN npm test

EXPOSE 3000/tcp
CMD ["npm", "start"]
