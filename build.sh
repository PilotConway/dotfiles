#!/bin/bash

FOLDERS="dotfiles/"
TAR="conway-dotfiles.tar.gz"
EXEC="install-dotfiles"

if [[ -f $EXEC ]]; then 
    rm $EXEC
fi

tar -czf $TAR $FOLDERS

cat install.sh $TAR > $EXEC
chmod a+x $EXEC 

rm $TAR
