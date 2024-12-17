# Base image
FROM node:18-slim

# Add curl and tini for health check and process management
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl tini && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/local/app

# Install nodemon globally for development use (file watching)
RUN npm install -g nodemon

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies and clean up cache
RUN npm ci && \
    npm cache clean --force && \
    mv /usr/local/app/node_modules /node_modules

# Copy application source code
COPY . .

# Set environment variables
ENV PORT 80

# Expose port 80
EXPOSE 80

# Use tini as the init system
ENTRYPOINT ["/usr/bin/tini", "--"]

# Command to run the application
CMD ["node", "server.js"]

