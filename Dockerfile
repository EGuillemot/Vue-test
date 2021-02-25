# Etape de developpement
FROM node:14.15.5-alpine3.11 as develop-stage
WORKDIR /vue_test
COPY package*.json ./
RUN npm install
COPY . .

# Etape de build
FROM develop-stage as build-stage
RUN npm run build

# Etape de production
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]