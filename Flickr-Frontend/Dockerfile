# Pull latest node image
FROM node:11
# Make /app root directory
WORKDIR /app
# Add to path variables
ENV PATH /app/node_modules/.bin:$PATH
# Copy packeges to install it
COPY package.json ./
COPY package-lock.json ./
RUN npm install 
#RUN npm install react-scripts@3.4.1 -g --silent
#RUN npm update --force
# Give npm some permissions
RUN npm config set unsafe-perm true
# Copy all files
COPY . ./
# Run on port 3000
EXPOSE 3000
# Start the app
CMD ["npm", "start"]