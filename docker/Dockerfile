FROM httpd:latest

RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/Lusitaniae/apache_exporter/releases/download/v0.9.0/apache_exporter-0.9.0.linux-amd64.tar.gz && \
    tar -xf apache_exporter-0.9.0.linux-amd64.tar.gz && \
    mv apache_exporter-0.9.0.linux-amd64/apache_exporter /usr/local/bin/ && \
    rm -rf apache_exporter-0.9.0.linux-amd64*

RUN echo "ExtendedStatus On" >> /usr/local/apache2/conf/httpd.conf
RUN echo "<Location \"/server-status\">\n  SetHandler server-status\n  Order deny,allow\n  Allow from all\n</Location>" >> /usr/local/apache2/conf/httpd.conf

EXPOSE 80
EXPOSE 9117

CMD ["sh", "-c", "apachectl -D FOREGROUND & apache_exporter"]
