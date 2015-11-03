# -*- Mode: Makefile; indent-tabs-mode:t; tab-width: 4 -*-
export GOPATH=$(PWD)

all:
	@echo $(GOPATH)
	go get -t -d github.com/grafana/grafana
	cd $(GOPATH)/src/github.com/grafana/grafana && git checkout v2.1.3 && go run build.go setup && $(GOPATH)/bin/godep restore \
	&& GOARCH=arm GOARM=7 CGO_ENABLED=1 CC=arm-linux-gnueabihf-gcc go build .
	# go build .
install:
	mkdir -p $(DESTDIR)/bin
	cp bin/start-service.sh $(DESTDIR)/bin
clean:
	rm *.snap
distclean:
	rm src -rf
	rm pkg -rf
 
