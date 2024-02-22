# Base image (choose a recent, secure Node.js version)
FROM node:18-alpine AS builder

# Work directory
WORKDIR /app

# Copy package.json or yarn.lock for dependency installation
COPY yarn.lock ./

RUN nuxt generate

# Install dependencies (adjust the command if needed)
RUN yarn install

# Copy the rest of your app's source code
COPY . .

# Build the Nuxt.js app for production
RUN yarn build

# New stage for optimized runtime image
FROM node:18-alpine AS runner

# Work directory
WORKDIR /app

# Copy only the generated `dist` folder
COPY --from=builder /app/dist ./

# Expose the port Cloud Run provides (environment variable)
EXPOSE $PORT

# Set the default command to start the Nuxt.js app in production mode
CMD ["yarn", "start"]
