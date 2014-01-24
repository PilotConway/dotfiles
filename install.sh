#!/bin/bash

## 
# Variables
##
HOME=$(readlink -f ~/)
TMPDIR=/tmp/dotfiles
THIS=`pwd`/$0

# make the temp directory
mkdir -p $TMPDIR

## 
# Extract the tarball from this archive
##
echo -n "Extracting Tarball..."
# get the number of lines of this script 
SKIP=`awk '/^__ARCHIVE_FOLLOWS__/ { print NR + 1; exit 0; }' $0`
# extract the lines after this script which will be the embedded tarball.
tail -n+$SKIP $THIS | tar -xzf - -C $TMPDIR
echo "Done"

# remove the temp directory
#rm -rf $TMPDIR

# Exit and make sure the tarball below isn't run. 
exit 0

# Mark the end of this script and the beginning of the archive. 
__ARCHIVE_FOLLOWS__
