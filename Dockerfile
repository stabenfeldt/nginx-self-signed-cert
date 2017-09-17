# This image is based on the popular Alpine Linux project,
# available in the alpine official image. Alpine Linux is much smaller than most
# distribution base images (~5MB), and thus leads to much slimmer images in general.
FROM nginx:1.12-alpine-perl


RUN apk update && apk add \
  certbot \
  curl


# establish where Nginx should look for files
ENV RAILS_ROOT /var/www/sst

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# create log directory
RUN mkdir log

# copy over static assets
COPY public public/

# Copy Nginx config template
COPY nginx/nginx.conf /tmp/docker_example.nginx

# substitute variable references in the Nginx config template for real values
# from the environment put the final config in its place
#
RUN envsubst '$RAILS_ROOT' < /tmp/docker_example.nginx > /etc/nginx/conf.d/default.conf

COPY nginx/sites-available/mydomain.conf /etc/nginx/sites-available/mydomain.conf
COPY nginx/snippets/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
COPY nginx/snippets/self-signed.conf /etc/nginx/snippets/self-signed.conf

# Create self signed sertificates:
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# -keyout nginx-selfsigned.key -out nginx-selfsigned.crt

COPY nginx/nginx-selfsigned.crt  /etc/ssl/certs/nginx-selfsigned.crt;
COPY nginx/nginx-selfsigned.key  /etc/ssl/private/nginx-selfsigned.key;


EXPOSE 80 443


# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD ["nginx", "-g", "daemon off;"]

