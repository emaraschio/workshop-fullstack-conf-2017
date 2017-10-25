FROM node:6.10

RUN mkdir /app
WORKDIR /app
COPY package.json package.json 
COPY . /app

RUN npm install

RUN npm run build

EXPOSE  3000

CMD npm start