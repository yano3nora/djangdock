FROM nginx:1.15.6

# Fix settings.
ARG  DOMAIN
COPY ./default.conf /etc/nginx/conf.d/default.conf
RUN  sed -e "s/localhost/${DOMAIN}/g" -i /etc/nginx/conf.d/default.conf
RUN  cat /etc/nginx/conf.d/default.conf

# Run web server.
CMD nginx -g "daemon off;"
