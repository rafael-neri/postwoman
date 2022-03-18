FROM node:16-alpine3.14

RUN apk add --update --no-cache git

WORKDIR /app

COPY package*.json ./

RUN yarn install

COPY . .

RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
