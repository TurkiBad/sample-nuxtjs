FROM node:18 


WORKDIR /app

ENV PORT 8080
ENV HOST 0.0.0.0

COPY package*.json ./

RUN yarn install

COPY . .

RUN yarn run generate

RUN yarn run build

EXPOSE 8080

CMD yarn start
