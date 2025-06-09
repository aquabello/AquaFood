# Use an official Node runtime as a parent image
FROM node:18-alpine As development

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./
# COPY yarn.lock ./ # Uncomment if using yarn

# Install dependencies
RUN npm install
# RUN yarn install # Uncomment if using yarn

# Copy the rest of the application files
COPY . .

# Build the Nuxt.js application for production
RUN npm run build
# RUN yarn build # Uncomment if using yarn

# Production stage
FROM node:18-alpine As production

WORKDIR /app

# Copy built assets from development stage
COPY --from=development /app/.output ./.output
COPY --from=development /app/node_modules ./node_modules
COPY --from=development /app/package.json ./package.json

# Expose the port the Nuxt.js app runs on
EXPOSE 3000

# Command to run the Nuxt.js application
CMD ["node", ".output/server/index.mjs"]
