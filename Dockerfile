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
CMD ["node", "dist/apps/dev/main.js"]


###################
# BUILD FOR PRODUCTION
###################
FROM node:18-alpine As build

WORKDIR /home/source
RUN apk update
RUN apk add --no-cache python3 py3-pip build-base
RUN apk --no-cache add curl

COPY package.json .
RUN yarn install --frozen-lockfile --production && yarn cache clean

COPY . .
RUN yarn build


###################
# PRODUCTION
###################
FROM node:18-alpine As production

COPY --from=build /home/source/node_modules ./node_modules
COPY --from=build /home/source/dist ./dist
COPY --from=build /home/source/libs ./libs
COPY .env.production .env

#CMD ["node", "dist/apps/auth-microservice/main.js"]
#CMD ["node", "dist/apps/conversations/main.js"]
#CMD ["node", "dist/apps/friends/main.js"]
#CMD ["node", "dist/apps/campaigns/main.js"]
#CMD ["node", "dist/apps/reports/main.js"]
CMD ["node", "dist/apps/dev/main.js"]




