###################
# BUILD FOR LOCAL DEVELOPMENT
###################
FROM node:18-alpine As development
# Arguments defined in docker-compose.yml
WORKDIR /home/source

COPY package.json ./
COPY yarn.lock ./
RUN apk update
RUN apk add --no-cache python3 py3-pip build-base
RUN rm -rf /home/source/node_modules
RUN rm -rf /home/source/package-lock.json
RUN apk --no-cache add curl
RUN yarn install
#CMD ["yarn", "serve"]
CMD ["node", "dist/apps/conversations/main.js"]



