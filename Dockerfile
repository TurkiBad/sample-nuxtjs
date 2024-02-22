# Base image (consider recent, secure Node.js version)
FROM node:18-alpine AS builder

# Work directory
WORKDIR /app

# Copy package.json or yarn.lock for dependency installation
COPY package*.json yarn.lock ./

# Install dependencies (using yarn in your case)
RUN yarn install --production

# Copy the entire project to the container
COPY . .

RUN yarn nuxt generate

# New stage for optimized runtime image
FROM node:18-alpine AS runner

# Work directory
WORKDIR /app

# Copy only the generated `dist` folder (if nuxt.config.js outputDir is set to dist)
COPY --from=builder /app ./

# Expose the port Cloud Run provides (environment variable)
EXPOSE 8080

# Set the default command to start the Nuxt.js app in production mode
CMD ["yarn", "start"]
