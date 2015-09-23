FROM joaquindlz/rpi-docker-lamp:latest
RUN rm -fr /app && git clone https://github.com/sconrads/fuTelldus.git /app
EXPOSE 80 3306

RUN apt-get update
RUN apt-get -q -y install php-pear
RUN apt-get -q -y install vim
RUN apt-get -q -y install cron
RUN echo "*/15 * * * * php -q /app/cron_temp_log.php" | crontab -
RUN echo "*/5 * * * * php -q /app/cron_schedule.php" | crontab -   
RUN pear install channel://pear.php.net/HTTP_OAuth-0.3.1
RUN cp -r /usr/share/php/HTTP/* /app
CMD ["/run.sh"]

# Add a data container for the mysql database
# You can use this Dockerfile: https://github.com/sconrads/fuTelldus-docker-data-container
# Exec into container and run these scripts
# mysql -u root -e "CREATE DATABASE futelldus"
# mysql -u root -D futelldus < /app/fuTelldus.sql
# More info: http://www.alexecollins.com/docker-persistence/
