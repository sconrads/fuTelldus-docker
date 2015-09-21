FROM joaquindlz/rpi-docker-lamp:latest
RUN rm -fr /app && git clone https://github.com/sconrads/fuTelldus.git /app
EXPOSE 80 3306

RUN apt-get update
RUN apt-get -q -y install php-pear 
RUN pear install channel://pear.php.net/HTTP_OAuth-0.3.1
RUN cp -r /usr/share/php/HTTP/* /app
CMD ["/run.sh"]

# Exec into container and run these scripts
# mysql -u root -e "CREATE DATABASE futelldus"
# mysql -u root -D futelldus < /app/fuTelldus.sql
