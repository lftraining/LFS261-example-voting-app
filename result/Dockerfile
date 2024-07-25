FROM node:22.4.0-alpine

WORKDIR /app 

COPY . . 

RUN npm install  && \ 
    npm audit fix 
    
EXPOSE 4000

CMD npm start 
