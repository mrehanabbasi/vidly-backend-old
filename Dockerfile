FROM node:12.17.0-alpine

LABEL name="Vidly" \
  maintainer="MRA" \
  summary="Backend of a Node Express video rental application."

ENV PORT=3900

WORKDIR /app

# EXPOSE $PORT

# RUN groupadd -r vidly && useradd -m -r -g -s /bin/bash vidly vidly

# USER vidly

COPY package*.json ./

RUN npm install

COPY . .

CMD ["npm", "start"]
