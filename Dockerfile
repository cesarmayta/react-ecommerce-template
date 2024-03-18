FROM node:16.18.1 as builder
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN ["npm", "run", "build"]

FROM nginx
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
CMD ["nginx","-g","daemon off;"]
