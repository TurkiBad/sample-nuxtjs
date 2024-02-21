# Use a specific Node.js version (16-alpine recommended for production)
FROM node:16-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies: Copy package*.json and package-lock.json (if using yarn.lock) and run yarn install
COPY package*.json ./
COPY package-lock.json ./  # Add yarn.lock if applicable
RUN yarn install

# Copy remaining application files and perform Nuxt build:
COPY . .

# Build the Nuxt app: Ensure yarn build succeeds before copying
RUN yarn build

# Production image:
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Copy the built output from the builder stage: Verify the path exists
COPY --from=builder /app/dist .

# Expose the port used by the app (Nuxt typically uses 3000)
EXPOSE 3000

# Start the app using the appropriate command
CMD ["yarn", "start"]
