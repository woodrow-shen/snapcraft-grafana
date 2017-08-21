# snapcraft-grafana

The purpose is to use [snapcraft](https://github.com/snapcore/snapcraft) to build the grafana as snap package.  

## Requirement

You need to have a go 1.8+ environment by using gvm for go version control:
```bash
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source ./.gvm/scripts/gvm
gvm install go1.8.3
gvm use go1.8.3 --default
```

Importantly, installing snapcraft:
```bash
sudo apt-get update
sudo apt-get install snapcraft
```

### Install nvm (Use LTS Release)

```bash
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs
```

## How to build

Run `snapcraft` to build a snap.

## How to rebuild

```bash
snapcraft clean
snapcraft
```

## Phantomjs issue for building armhf arch

For armhf, I hit the phantomjs build failed with compiling the grafana,  
and I forked the phantomjs to work around errors by refering this link [2].
After getting a successful compilation of phantomjs, just copy binary  
`bin/phantomjs` to `/usr/bin`.

To fork my works:

```bash
git clone git@github.com:woodrow-shen/phantomjs.git
```
[1] https://tecadmin.net/install-latest-nodejs-npm-on-ubuntu
[2] https://github.com/aeberhardo/phantomjs-linux-armv6l 
