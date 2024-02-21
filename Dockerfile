# Use an official Node.js image as the base
FROM node:18

# Set the working directory to /app
WORKDIR /app

# Copy the dependencies file
COPY package*.json ./

# Install the dependencies
RUN yarn install
RUN yarn build

# Copy the application code
COPY . /app

# Expose the port
EXPOSE 80

# Run the command to start the application
CMD ["yarn", "start"]