FROM node:20-alpine
WORKDIR /app

COPY package.json ./
RUN npm install --omit=dev && npm cache clean --force

COPY . .

# data directory (ephemeral on the free plan: it is wiped on restart/redeploy)
RUN mkdir -p /data && chown -R node:node /data /app

# keep Node's heap inside the 256 MB free-plan limit
ENV NODE_ENV=production \
    PORT=3000 \
    NODE_OPTIONS=--max-old-space-size=160

USER node
EXPOSE 3000
CMD ["node", "server.js"]
