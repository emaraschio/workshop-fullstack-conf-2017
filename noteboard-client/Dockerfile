FROM node:6.10

RUN mkdir /app
WORKDIR /app
COPY package.json package.json 
COPY . /app

RUN npm install

RUN PORT=4000 npm run build

EXPOSE  4000

CMD npm start