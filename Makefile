# -*- Mode: Makefile; indent-tabs-mode:t; tab-width: 4 -*-
export GOPATH=$(PWD)/parts/grafana

VERSION := 2.1.3-1
PACKAGE := grafana_$(VERSION)_armhf.snap

all:
	@echo $(GOPATH)
	go get -t -d github.com/grafana/grafana
	cd $(GOPATH)/src/github.com/grafana/grafana && git checkout v2.1.3 && go run build.go setup && $(GOPATH)/bin/godep restore && go build . 
	# currenlty snapcraft can't support cross build
	#&& GOARCH=arm GOARM=7 CGO_ENABLED=1 CC=arm-linux-gnueabihf-gcc go build .
	cd $(GOPATH)/src/github.com/grafana/grafana && npm install
	cd $(GOPATH)/src/github.com/grafana/grafana && npm install -g grunt-cli
	cd $(GOPATH)/src/github.com/grafana/grafana && grunt	
install:
	mkdir -p $(DESTDIR)/bin
	mkdir -p $(DESTDIR)/usr/share/grafana
	cp bin/start-service.sh $(DESTDIR)/bin
	cp parts/grafana/src/github.com/grafana/grafana/grafana $(DESTDIR)/bin
	cp -r parts/grafana/src/github.com/grafana/grafana/conf $(DESTDIR)/usr/share/grafana
	cp -r parts/grafana/src/github.com/grafana/grafana/public $(DESTDIR)/usr/share/grafana
clean:
	snapcraft clean
	@if [ -f $(PACKAGE) ] ; then rm *.snap ; fi 
distclean: clean
 
