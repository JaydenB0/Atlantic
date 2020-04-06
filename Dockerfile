# Container for Client Build
FROM node:lts as client-builder
WORKDIR /build
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY yarn.lock yarn.lock
COPY client client
 
WORKDIR /build/client
 

RUN yarn
RUN yarn build:prod


# COntainer for server build
FROM node:lts as server-builder

WORKDIR /build
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY yarn.lock yarn.lock
COPY . .

WORKDIR /build/server

RUN yarn
RUN yarn build:prod

# Production container, as lightweight as possible
FROM node:lts-alpine
ENV PORT 80

WORKDIR /atlantic

# Copy Client side code
COPY --from=client-builder client/build client/build

COPY --from=server-builder /build/server/build server/build

# Copy Global configs
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY yarn.lock yarn.lock
# Copy Client configs
COPY client/package.json client/package.json
COPY client/package-lock.json client/package-lock.json
COPY client/yarn.lock client/yarn.lock
# Copy Server configs
COPY server/package.json server/package.json
COPY server/package-lock.json server/package-lock.json
COPY server/yarn.lock server/yarn.lock

# install
RUN yarn --production

EXPOSE 80
CMD yarn start
