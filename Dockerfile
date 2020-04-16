# first create a container that allow 'npm run build'
# npm run build creates the /build folder and that's
# final code we need to put into production web server
FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# now create nginx container and copy the /build folder
# into the container
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html