FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY ./dist/* ./
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]