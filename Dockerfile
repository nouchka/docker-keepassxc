# hadolint ignore=DL3007
FROM jess/keepassxc:latest

## LATEST_RELEASE=2.5.3

RUN adduser -D -u 1000 developer && apk --no-cache add libqrencode=* qt5-qtsvg=*
USER developer
