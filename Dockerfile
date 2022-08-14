FROM node:lts-bullseye

RUN yarn global add ts-node

COPY . /app

WORKDIR /app

RUN yarn

ENTRYPOINT ["ts-node", "/app/lib/main.ts"]

