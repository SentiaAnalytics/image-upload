FROM node:6.1.0
run mkdir /app
workdir /app

ADD src src
ADD public public
COPY package.json package.json

RUN npm install --prod

ENV PORT=80

EXPOSE 80
VOLUME ["/app/public/files"]

CMD ["npm", "start"]
