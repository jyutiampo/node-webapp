FROM node:lts-slim
WORKDIR /home/node/app
# First copy package files
COPY package.json package-lock.json ./
# Then install dependencies
RUN npm install
# Finally copy all other files
COPY . .
CMD ["npm", "start"]
