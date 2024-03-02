FROM node:latest AS buildStage

WORKDIR /src

COPY package*.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine AS productionStage

WORKDIR /usr/share/nginx/html

COPY --from=buildStage src/build .

EXPOSE 80