FROM node
LABEL author="Hernan"
WORKDIR /app
COPY package*.json ./
RUN npm install
#RUN npm ci --only=production
COPY . .
EXPOSE 3000
ENTRYPOINT ["npm", "start"]
