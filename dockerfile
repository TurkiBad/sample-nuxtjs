FROM node:16-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN yarn install

COPY . .
RUN yarn build

FROM node:16-alpine

WORKDIR /app

COPY --from=builder /app/dist .

EXPOSE 3000
CMD ["yarn", "start"]