#!/bin/bash
#
# Run this bash script as sudo to install 
# JASP on Debian or Ubuntu 14.10+ and Ubuntu 15.10
#
# see JASP website: https://jasp-stats.org/
#
# (c) 2015 Oliver Lindemann, MIT license

VERSION="0.7.1-Beta2"
JASP="JASP-$VERSION"
DEST="/opt"
TMP="/tmp"

# select distribution
echo
echo "Installing JASP $VERSION"
echo "Select distribution, for which JASP should be installed:"
echo "   1) Ubuntu 14.04 LTS (Trusty Tahr) 64-bit"
echo "   2) Ubuntu 15.04 (Vivid Vervet) 64-bit"
echo ""
echo "   or type 'uninstall' to uninstall ALL JASP versions"
echo ""
echo -n "   >> "
read selct
if [ "$selct" = "1" ] ; then
    DISTRI="U1404"
elif [ "$selct" = "2" ] ; then
    DISTRI="U1504" 
elif [ "$selct" = "uninstall" ] ; then
    rm -rf $DEST/JASP-*
	rm -f /usr/bin/jasp-*
	rm -f /usr/share/applications/jasp-*
	echo "JASP has been uninstalled!"
	exit
else
    echo "Installation quitted!"
	exit
fi

SOURCEZIP="$JASP-${DISTRI}.zip"
URL="https://static.jasp-stats.org/$SOURCEZIP"

# install dependencies
sudo apt-get install libboost-dbg libqt5webkit5 liblapack3 libblas-common libarchive13 libqt5svg5 

#download zip
echo "Downloading $SOURCEZIP"
rm -f $TMP/$SOURCEZIP
wget -P $TMP $URL

# install
cd $TMP
sudo rm -rf $JASP
sudo rm -rf $DEST/$JASP
unzip $TMP/$SOURCEZIP
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
