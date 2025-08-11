#!/bin/bash

apt-get install build-essential cmake pkgconf libreadline8 libusb-0.1 libgpgme11 libarchive-tools fakeroot

curl -LO https://github.com/pspdev/pspdev/releases/download/v20250801/pspdev-ubuntu-24.04-arm-arm64.tar.gz

tar -xvzf pspdev-ubuntu-24.04-arm-arm64.tar.gz -C /usr/local/

rm -f pspdev-ubuntu-24.04-arm-arm64.tar.gz
