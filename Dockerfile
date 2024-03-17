# Use a minimal base image
FROM node:alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the project files
COPY . .

# Use a smaller image for serving
FROM nginx:alpine

# Copy the built Vue app from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose the port (default for Vue apps is 8080)
EXPOSE 3000

# Configure the default server block
CMD ["nginx", "-g", "daemon off;"]