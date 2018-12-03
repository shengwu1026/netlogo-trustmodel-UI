FROM node:11.3 as builder
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY src/ ./src
COPY public/ ./public
RUN npm run build

FROM nginx:1.15-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]