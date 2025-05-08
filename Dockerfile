# Dockerfile
FROM node:18

# Set working directory inside the container
WORKDIR /app

# Copy only package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all other files
COPY . .

# Build the project (e.g., for React)
RUN npm run build

# Install serve globally to serve static files
RUN npm install -g serve

# Serve the build folder on port 3000
CMD ["serve", "-s", "build", "-l", "3000"]
