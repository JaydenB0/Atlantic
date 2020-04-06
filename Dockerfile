# Container for Client Build
FROM node:lts as client-builder
WORKDIR /build

COPY package.json package.json
COPY package-lock.json package-lock.json
COPY yarn.lock yarn.lock
COPY client client
 
WORKDIR /build/client
 
RUN yarn
RUN yarn --cwd build:prod


# Container for server build
FROM node:lts as server-builder

WORKDIR /build

COPY package.json package.json
COPY package-lock.json package-lock.json
COPY yarn.lock yarn.lock
COPY . .

WORKDIR /build/server

RUN yarn
RUN yarn --cwd build:prod

# Production container, as lightweight as possible
FROM node:lts-alpine
ENV PORT 80

WORKDIR /atlantic

# Copy Client side code
COPY --from=client-builder /build/client client

COPY --from=server-builder /build/server server

# Copy Global configs
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY yarn.lock yarn.lock

# install
RUN yarn --production

EXPOSE 80
CMD yarn start
