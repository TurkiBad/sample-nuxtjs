# Base image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and yarn.lock to the container
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --production

# Copy the entire project to the container
COPY . .

# Build the Nuxt.js application
RUN yarn build

# Expose the port on which the application will run
EXPOSE 8080

# Start the application
CMD [ "yarn", "start" ]