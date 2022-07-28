# hadolint ignore=DL3007
FROM jess/keepassxc:latest

ARG VERSION=2
## LATEST_RELEASE=2.5.3

# hadolint ignore=DL3018
RUN adduser -D -u 1000 developer && apk --no-cache add libqrencode qt5-qtsvg
USER developer
