FROM jess/keepassxc:latest

RUN adduser -D -u 1000 developer
USER developer
