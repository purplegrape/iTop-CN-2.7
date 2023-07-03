# syntax=docker/dockerfile:1
FROM docker.io/library/ubuntu:20.04
LABEL org.opencontainers.image.title=iTop \
      org.opencontainers.image.version=2.7.8 \
      org.opencontainers.image.description="iTop-2.7.8 & ubuntu-20.04 & apache-2.4.41 & php-7.4.3" \
      org.opencontainers.image.authors="purplegrape4@gmail.com"

RUN DEBIAN_FRONTEND=noninteractive apt-get update ;\
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y apache2 libapache2-mod-php7.4 php7.4-opcache php7.4-curl php7.4-gd php7.4-mbstring php7.4-mysql php7.4-ldap php7.4-xml php7.4-soap php7.4-zip php-apcu graphviz tzdata rsync ;\
    DEBIAN_FRONTEND=noninteractive apt-get autoclean

RUN sed -i '/AllowOverride/s/None/All/g' /etc/apache2/apache2.conf
RUN sed -i 's#ErrorLog.*#ErrorLog /proc/self/fd/2#g' /etc/apache2/apache2.conf /etc/apache2/sites-available/*.conf
RUN sed -i 's#CustomLog.*#CustomLog /proc/self/fd/1 combined#g' /etc/apache2/sites-available/*.conf
RUN rm -rf /var/lib/apt/lists/* /etc/apache2/conf-available/other-vhosts-access-log.conf
RUN mkdir -p /var/www/html ;rm -rf /var/www/html

ADD itop.tar /usr/src/

ADD --chmod=755 entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
