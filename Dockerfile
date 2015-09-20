FROM joaquindlz/rpi-docker-lamp:latest
RUN rm -fr /app && git clone https://github.com/sconrads/fuTelldus.git /app
EXPOSE 80 3306
CMD mysql -u root -e "CREATE DATABASE futelldus"
CMD mysql -u root -D futelldus < /app/fuTelldus.sql
CMD ["/run.sh"]
