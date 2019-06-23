#!/bin/bash

set -e # fail on any error
set -u # treat unset variables as error
rm -rf deb
#create DEBIAN files
mkdir -p deb/usr/bin/
mkdir -p deb/DEBIAN
#create copyright, docs, compat
cp LICENSE deb/DEBIAN/copyright
echo "https://octonion.institute/susytech/susy-bitcoin/" >> deb/DEBIAN/docs
echo "8" >> deb/DEBIAN/compat
#create control file
control=deb/DEBIAN/control
echo "Package: susybtc" >> $control
version=`grep -m 1 version Cargo.toml | awk '{print $3}' | tr -d '"' | tr -d "\n"`
echo "Version: $version" >> $control
echo "Source: susybtc" >> $control
echo "Section: science" >> $control
echo "Priority: extra" >> $control
echo "Maintainer: Susy Technologies <devops@superstring.io>" >> $control
echo "Build-Depends: debhelper (>=9)" >> $control
echo "Standards-Version: 3.9.5" >> $control
echo "Homepage: http://superstring.io" >> $control
echo "Vcs-Git: git://octonion.institute/susytech/susy-bitcoin.git" >> $control
echo "Vcs-Browser: https://octonion.institute/susytech/susy-bitcoin" >> $control
echo "Architecture: $1" >> $control
echo "Depends: libssl1.0.0 (>=1.0.0)" >> $control
echo "Description: Bitcoin network client by Susy Technologies" >> $control
#build .deb package

exit
