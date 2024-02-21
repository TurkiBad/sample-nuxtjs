# Use an official Node.js image as the base
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Copy the dependencies file
COPY package*.json ./

# Install the dependencies
RUN yarn install

# Copy the application code
COPY . .

# Expose the port
EXPOSE 3000

# Run the command to start the application
CMD ["yarn", "start"]