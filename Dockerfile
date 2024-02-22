# Base image (choose a recent, secure Node.js version)
FROM node:18 AS builder

# Work directory
WORKDIR /app

# Copy package.json or yarn.lock for dependency installation
COPY package*.json

# Install dependencies (using yarn)
RUN yarn install

# Copy the rest of your app's source code
COPY . .

# Install nuxt globally using yarn
RUN yarn global add nuxt

# **Place here:** Generate static files before starting
RUN nuxt generate

# New stage for optimized runtime image
FROM node:18 AS runner

# Work directory
WORKDIR /app

# Copy only the generated `dist` folder
COPY --from=builder /app/dist ./

# Expose the port Cloud Run provides (environment variable)
EXPOSE 8080

# Set the default command to start the Nuxt.js app in production mode
CMD ["yarn", "start"]
