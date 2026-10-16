# Use an official Node image
FROM node:20

# Set working directory inside container
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the frontend code
COPY . .

# Expose port
EXPOSE 3000

# Default command (dev server)
CMD ["npm", "run", "dev"]
