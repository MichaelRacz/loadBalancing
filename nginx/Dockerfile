FROM nginx

RUN rm /usr/share/nginx/html/*
RUN rm /etc/nginx/conf.d/*
COPY ./nginx.conf /etc/nginx/conf.d

VOLUME /etc/nginx
