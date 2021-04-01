FROM dockershelf/python:3.7
LABEL maintainer "Nahla Abdulla <nahla1707@gmail.com>"

RUN apt-get update && \
    apt-get install net-tools netcat-openbsd

RUN route -n | awk '/^0.0.0.0/ {print $2}' > /tmp/host_ip.txt
RUN echo "HEAD /" | nc `cat /tmp/host_ip.txt` 8000 | grep squid-deb-proxy \
    && (echo "Acquire::http::Proxy \"http://$(cat /tmp/host_ip.txt):8000\";" > /etc/apt/apt.conf.d/30proxy) \
    || echo "No squid-deb-proxy detected on docker host"

RUN apt-get update && \
    apt-get install gnupg sudo

RUN useradd -ms /bin/bash nahlaalhebsi
RUN echo "nahlaalhebsi ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nahlaalhebsi

ADD requirements.txt /root/
RUN pip install -r /root/requirements.txt
RUN rm /root/requirements.txt

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
