FROM joaquindlz/rpi-docker-lamp:latest
RUN rm -fr /app && git clone https://github.com/sconrads/fuTelldus.git /app
EXPOSE 80 3306

RUN apt-get update
RUN apt-get -q -y install php-pear
RUN apt-get -q -y install vim

# Install dependencies
RUN apt-get update && apt-get install -y \
    cron \
    rsyslog \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Import crontab file
ADD ./crontab /etc/crontab
RUN touch /var/log/cron.log

RUN pear install channel://pear.php.net/HTTP_OAuth-0.3.1
RUN cp -r /usr/share/php/HTTP/* /app

CMD ./run.sh && rsyslogd && cron && tail -f /var/log/syslog /var/log/cron.log

# Add a data container for the mysql database
# You can use this Dockerfile: https://github.com/sconrads/fuTelldus-docker-data-container
# Exec into container and run these scripts
# mysql -u root -e "CREATE DATABASE futelldus"
# mysql -u root -D futelldus < /app/fuTelldus.sql
# More info: http://www.alexecollins.com/docker-persistence/
