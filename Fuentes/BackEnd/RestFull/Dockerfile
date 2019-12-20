FROM node
LABEL author="Ing. Jose Perez - Soltecn Peru"
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
ENTRYPOINT ["npm", "start"]


# FROM node:latest

# # Create app directory
# RUN mkdir -p /usr/src
# WORKDIR /usr/src

# # Install app dependencies
# COPY package.json /usr/src/
# RUN npm install

# # Bundle app source
# COPY . /usr/src

# EXPOSE 3000
# CMD [ "node", "api/server.js" ]

# FROM node:latest
# RUN mkdir /src
# WORKDIR /src
# COPY package.json /src/
# COPY . /src
# RUN npm install
# EXPOSE 3000
# CMD [ "node", "server.js" ]
