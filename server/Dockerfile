FROM node

WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm test
COPY . .

EXPOSE 3001
CMD ["npm","start"]