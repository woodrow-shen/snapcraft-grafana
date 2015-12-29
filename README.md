# snapcraft-grafana

The purpose is to use [snapcraft](https://developer.ubuntu.com/en/snappy/build-apps/snapcraft-advanced-features/) to build the grafana as snap package.  
Currently, the arch type of binary is for armhf.

## Requirement

You need to have a go 1.4+ environment by using gvm for go version control:
```bash
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source ./.gvm/scripts/gvm
gvm install go1.4
gvm use go1.4
gvm install go1.5
gvm use go1.5 --default
```

Importantly, installing snapcraft:
```bash
sudo add-apt-repository ppa:snappy-dev/tools
sudo apt-get update
sudo apt-get install snapcraft
```

### Install nvm

```bash
sudo apt-get install nodejs
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
nvm install 0.12
nvm use 0.12
```

## How to build

Run `snapcraft` to build a snap.

## How to rebuild

```bash
snapcraft clean
snapcraft
```

## snapcraft commands

`snapcraft pull`: get source  
`snapcraft build`: build parts  
`snapcraft stage`: put parts into staging area  
`snapcraft snap`: put parts into snap area  
`snapcraft all`: make a snap package  

## Phantomjs issue for building armhf arch

For armhf, I hit the phantomjs build failed with compiling the grafana,  
and I forked the phantomjs to work around errors by refering this link [1].  
After getting a successful compilation of phantomjs, just copy binary  
`bin/phantomjs` to `/usr/bin`.

To fork my works:

```bash
git clone git@github.com:woodrow-shen/phantomjs.git
```
[1] https://github.com/aeberhardo/phantomjs-linux-armv6l
