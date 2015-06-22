#!/bin/bash
#
# Run this bash script as sudo to install 
# JASP on Debian or Ubuntu 14.10+ and Ubuntu 15.10
#
# see JASP website: https://jasp-stats.org/
#
# (c) 2015 Oliver Lindemann, MIT license

VERSION="0.6.6"
DISTRI="U1410"

JASP="JASP-$VERSION-$DISTRI"
SOURCEZIP="$JASP.zip"
URL="https://static.jasp-stats.org/$SOURCEZIP"
DEST="/opt"
TMP="/tmp"

# dependencies
sudo apt-get install libboost-dbg libqt5webkit5 liblapack3 libblas-common libarchive13 libqt5svg # download

#download zip
echo "Downloading $SOURCEZIP"
rm -f $TMP/$SOURCEZIP
wget -P $TMP $URL

# install
cd $TMP
unzip $TMP/$SOURCEZIP
sudo rm -rf $DEST/$JASP
sudo mv -f $JASP $DEST
sudo ln -fs $DEST/$JASP/JASP /usr/bin/jasp-$VERSION

# application menu
sudo echo "[Desktop Entry]
Exec=$DEST/$JASP/JASP %F
Icon=None
Type=Application
Terminal=false
Name="JASP $VERSION"
Categories=Development;Science;" > /usr/share/applications/jasp-${VERSION}.desktop
