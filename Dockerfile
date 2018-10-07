FROM ubuntu:bionic

# Packages
RUN apt-get update && \
    apt-get install -y nginx-light fcgiwrap supervisor openssh-server cron rsync python3-pip

# Nexus user for application usage
RUN useradd --create-home nexus && \
    echo "nexus:nexus" | chpasswd && \
    install -d /home/nexus/.ssh -o nexus -g nexus -m 700 && \
    ln -s /data/nexus_authorized_keys /home/nexus/.ssh/authorized_keys

# Misc conf
RUN mkdir /start.d /nexus /var/run/sshd && \
    chown nexus /nexus && \
    rm /etc/ssh/ssh_host_* && \
    mkdir /etc/ssh/keys && \
    sed -i -E 's/#?HostKey \/etc\/ssh\//HostKey \/data\/keys\//' /etc/ssh/sshd_config && \
    rm -rf /var/lib/apt/lists/*

# Supervisor confs
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf
ADD supervisor-fcgiwrap.conf /etc/supervisor/conf.d/fcgiwrap.conf
ADD supervisor-sshd.conf /etc/supervisor/conf.d/sshd.conf
ADD supervisor-cron.conf /etc/supervisor/conf.d/cron.conf

# nginx confs
ADD nginx.conf /etc/nginx/nginx.conf
ADD default /etc/nginx/sites-available/default
ADD fastcgi_params /etc/nginx/fastcgi_params

# scripts
ADD scripts/nexus /tmp/nexus
RUN cd /tmp/nexus && python3 setup.py install && rm -rf /tmp/nexus

# Startup tasks
ADD clear-sockets /start.d/clear-sockets
ADD gen-ssh /start.d/gen-ssh
ADD dir-setup /start.d/dir-setup
ADD start /start

RUN chmod +x /start.d/clear-sockets /start.d/gen-ssh /start.d/dir-setup /start

ENTRYPOINT ["/start"]

EXPOSE 80
EXPOSE 22
