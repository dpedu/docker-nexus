FROM basessh
MAINTAINER Dave P

# Create nexus user
RUN useradd --create-home nexus ; \
    echo "nexus:nexus" | chpasswd

# Install nginx
RUN apt-get install -y nginx-light fcgiwrap

# Configure nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf ; cp /usr/share/doc/fcgiwrap/examples/nginx.conf /etc/nginx/fcgiwrap.conf

COPY nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY fcgiwrap.conf /etc/supervisor/conf.d/fcgiwrap.conf
COPY default /etc/nginx/sites-available/default
COPY clear-sockets /start.d/clear-sockets

RUN chmod +x /start.d/clear-sockets

EXPOSE 80

