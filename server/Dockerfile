# Pull latest node image
FROM node
# Make /app root directory
WORKDIR /app
# Copy packeges to install it
COPY package*.json ./
# Install all dependencies 
RUN npm install
# Copy all files
COPY . .
# Run on port 3001
EXPOSE 3001
# Start the app
CMD ["npm","start"]