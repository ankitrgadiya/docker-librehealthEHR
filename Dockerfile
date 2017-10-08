FROM debian:stretch
MAINTAINER Ankit R Gadiya <me@argp.in>

COPY config/apache.conf /etc/apache2/sites-available/apache.conf

RUN apt-get update \
	&& apt-get install -y \
		apache2 \
		php \
		libapache2-mod-php \
		php7.0-curl \
		php7.0-mysql \
		wget \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget https://gitlab.com/librehealth/LibreEHR/repository/master/archive.tar.gz \
	&& mkdir /var/www/app/ \
	&& tar -pxf archive.tar.gz --directory /var/www/app/ --strip-components=1 \
	&& rm -f archive.tar.gz \
	&& chown -R www-data:www-data /var/www/app \
	&& a2dissite 000-default.conf \
	&& a2ensite apache.conf

EXPOSE 80

CMD ["apachectl", "-DFOREGROUND"]
