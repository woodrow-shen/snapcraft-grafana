# -*- Mode: Makefile; indent-tabs-mode:t; tab-width: 4 -*-
export GOPATH=$(PWD)/parts/grafana

all:
	@echo $(GOPATH)
	go get -t -d github.com/grafana/grafana
	cd $(GOPATH)/src/github.com/grafana/grafana && git checkout v2.6.0
	cp dirty/package.json $(GOPATH)/src/github.com/grafana/grafana
	cp dirty/build_task.js $(GOPATH)/src/github.com/grafana/grafana/tasks
	cp dirty/default_task.js $(GOPATH)/src/github.com/grafana/grafana/tasks 
	cd $(GOPATH)/src/github.com/grafana/grafana && go run build.go setup && $(GOPATH)/bin/godep restore && go build . 
	# currenlty snapcraft can't support cross build
	#&& GOARCH=arm GOARM=7 CGO_ENABLED=1 CC=arm-linux-gnueabihf-gcc go build .
	cd $(GOPATH)/src/github.com/grafana/grafana && npm install
	cd $(GOPATH)/src/github.com/grafana/grafana && npm install -g grunt-cli
	cd $(GOPATH)/src/github.com/grafana/grafana && grunt --force
install:
	mkdir -p $(DESTDIR)/bin/
	mkdir -p $(DESTDIR)/conf/
	mkdir -p $(DESTDIR)/usr/share/grafana
	cp bin/start-service.sh $(DESTDIR)/bin/
	cp conf/defaults.ini $(DESTDIR)/conf/
	cp parts/grafana/src/github.com/grafana/grafana/grafana $(DESTDIR)/bin/
	cp -r parts/grafana/src/github.com/grafana/grafana/conf $(DESTDIR)/usr/share/grafana/conf
	cp -r parts/grafana/src/github.com/grafana/grafana/public_gen $(DESTDIR)/usr/share/grafana/public
clean:
	snapcraft clean
	rm *.snap
distclean: clean
 
