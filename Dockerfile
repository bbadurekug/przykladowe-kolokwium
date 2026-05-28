FROM node:20-alpine AS builder

WORKDIR /app

COPY /package*.json ./
RUN npm ci --omit=dev && npm cache clean --force


FROM node:20-alpine

WORKDIR /app

COPY --from=builder --chown=node /app ./
COPY --chown=node ./src ./src

EXPOSE 3000

USER node

CMD ["node", "./src/server.js"]