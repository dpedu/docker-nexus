FROM ubuntu:trusty
MAINTAINER Dave P

# Create nexus user
RUN useradd --create-home nexus && \
    echo "nexus:nexus" | chpasswd && \
    apt-get update && \
    apt-get install -y nginx-light fcgiwrap supervisor openssh-server cron && \
    mkdir /start.d /nexus /var/run/sshd && \
    chown nexus /nexus && \
    cp /usr/share/doc/fcgiwrap/examples/nginx.conf /etc/nginx/fcgiwrap.conf && \
    rm /etc/ssh/ssh_host_* && \
    mkdir /etc/ssh/keys && \
    sed -i -E 's/HostKey \/etc\/ssh\//HostKey \/etc\/ssh\/keys\//' /etc/ssh/sshd_config && \
    rm -rf /var/lib/apt/lists/*

# Supervisor confs
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf
ADD supervisor-fcgiwrap.conf /etc/supervisor/conf.d/fcgiwrap.conf
ADD supervisor-sshd.conf /etc/supervisor/conf.d/sshd.conf
ADD supervisor-cron.conf /etc/supervisor/conf.d/cron.conf

# nginx confs
ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx-default /etc/nginx/sites-available/default

# Startup tasks
ADD clear-sockets /start.d/clear-sockets
ADD gen-ssh /start.d/gen-ssh
ADD start /start

RUN chmod +x /start.d/clear-sockets /start

ENTRYPOINT ["/start"]

EXPOSE 80
EXPOSE 22
