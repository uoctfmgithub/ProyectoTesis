FROM node:latest
LABEL author="Ing. Jose Perez - Soltecn Peru"
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
ENTRYPOINT ["node", " api/server.js"]