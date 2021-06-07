FROM node

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm test

EXPOSE 3001
CMD ["npm","start"]