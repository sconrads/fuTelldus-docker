FROM joaquindlz/rpi-docker-lamp:latest
RUN rm -fr /app && git clone https://github.com/sconrads/fuTelldus.git /app
EXPOSE 80 3306
CMD mysql -u root -e "CREATE DATABASE futelldus"
CMD mysql -u root -D futelldus < /app/fuTelldus.sql
CMD apt-get update
CMD apt-get -q -y install php-pear 
CMD pear install channel://pear.php.net/HTTP_OAuth-0.3.1
CMD cp -r /usr/share/php/HTTP/* /app
CMD ["/run.sh"]
