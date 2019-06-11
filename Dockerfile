FROM jess/keepassxc:latest

RUN adduser -D -u 1000 developer && apk --no-cache add libqrencode qt5-qtsvg
USER developer
