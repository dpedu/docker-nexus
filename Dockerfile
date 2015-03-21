FROM basessh
MAINTAINER Dave P

# Create nexus user
RUN useradd --create-home nexus ; \
    echo "nexus:nexus" | chpasswd

# Install nginx
RUN apt-get install -y nginx-light

# Configure nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY default /etc/nginx/sites-available/default

EXPOSE 80

