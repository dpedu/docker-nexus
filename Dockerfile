FROM ubuntu:trusty
MAINTAINER Dave P

# Create nexus user
RUN useradd --create-home nexus ; \
    echo "nexus:nexus" | chpasswd

# Install nginx
RUN apt-get update ;\
    apt-get install -y nginx-light fcgiwrap supervisor openssh-server cron ;\
    mkdir /start.d /nexus /var/run/sshd ;\
    chown nexus /nexus

# Configure nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf ; cp /usr/share/doc/fcgiwrap/examples/nginx.conf /etc/nginx/fcgiwrap.conf

ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD nginx.conf /etc/supervisor/conf.d/nginx.conf
ADD fcgiwrap.conf /etc/supervisor/conf.d/fcgiwrap.conf
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf
ADD cron.conf /etc/supervisor/conf.d/cron.conf
ADD default /etc/nginx/sites-available/default
ADD clear-sockets /start.d/clear-sockets
ADD gen-ssh /start.d/gen-ssh
ADD start /start

RUN chmod +x /start.d/clear-sockets

EXPOSE 80
