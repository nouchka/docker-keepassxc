DOCKER_IMAGE=keepassxc
DOCKER_NAMESPACE=nouchka
NAME=$(DOCKER_NAMESPACE)-$(DOCKER_IMAGE)
VERSION=0.1
DESCRIPTION=$(DOCKER_IMAGE) with docker in a package
URL=https://github.com/nouchka/docker-$(DOCKER_IMAGE)
VENDOR=katagena
MAINTAINER=Jean-Avit Promis <docker@katagena.com>
LICENSE=Apache License 2.0

prefix = /usr/local

.DEFAULT_GOAL := build

deb:
	mkdir -p build/usr/sbin/
	cp -Rf bin/$(DOCKER_IMAGE) build/usr/sbin/

build-deb: deb
	rm -f $(NAME)_$(VERSION).$(TRAVIS_BUILD_NUMBER)_amd64.deb
	fpm -t deb -s dir -n $(NAME) -v $(VERSION).$(TRAVIS_BUILD_NUMBER) --description "$(DESCRIPTION)" -C build \
	--vendor "$(VENDOR)" -m "$(MAINTAINER)" --license "$(LICENSE)" --url $(URL) --deb-no-default-config-files \
	-d docker-ce \
	.
	rm -rf build/

push-deb: build-deb
	package_cloud push nouchka/home/ubuntu/xenial $(NAME)_*.deb

build:
	docker build -t $(DOCKER_NAMESPACE)/$(DOCKER_IMAGE) .

run:
	./bin/$(DOCKER_IMAGE)

check:
	docker run --rm -i hadolint/hadolint < Dockerfile

test: build run check

install:
	install bin/$(DOCKER_IMAGE) $(prefix)/bin
