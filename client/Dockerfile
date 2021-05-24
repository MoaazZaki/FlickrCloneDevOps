# Pull latest node image
FROM node:11
# Make /app root directory
WORKDIR /app
# Add to path variables
ENV PATH /app/node_modules/.bin:$PATH
# Copy packeges to install it
COPY package.json ./
COPY package-lock.json ./
COPY ./public/ ./public/ 
COPY ./src/ ./src/

RUN ls -d * */*
RUN ls -d * */*

RUN npx npm-force-resolutions
RUN npm install 
RUN npm run build
# Give npm some permissions
RUN npm config set unsafe-perm true
# Copy all files
COPY . ./
# Run on port 3000
EXPOSE 3000
# Start the app
CMD ["serve","-s build"]