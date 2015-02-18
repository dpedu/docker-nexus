FROM basessh
MAINTAINER Dave P

# Create user
RUN useradd --create-home nexus ; \
    echo "nexus:nexus" | chpasswd

COPY start /start
RUN chmod +x /start

