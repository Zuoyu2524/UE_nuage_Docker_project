FROM node:21.6.2-alpine3.18
WORKDIR /usr/local/app
COPY . .

RUN npm install -g nodemon

RUN npm ci \ 
&& npm cache clean --force \ 
&& mv /usr/local/app/node_modules /node_modules

EXPOSE 80
ENV PORT=80

CMD [ "node", "server.js" ]
