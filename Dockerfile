FROM haproxy:latest
COPY haproxy.conf.cfg /usr/local/etc/haproxy/haproxy.cfg
EXPOSE 80