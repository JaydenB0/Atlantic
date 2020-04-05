FROM node:13.12.0-alpine3.10
WORKDIR /usr/src/app

RUN npm install
# RUN npm ci --only=production

EXPOSE 8080
CMD [ "npm", "start"]