#!/bin/bash

FOLDERS="dotfiles/"
FILES="install.sh"
TAR="conway-dotfiles.tar.gz"
EXEC="install-dotfiles"
SELF_EXTRACTING_SCRIPT="tarball_exec.sh"

if [[ -f $EXEC ]]; then 
    rm $EXEC
fi

tar -czf $TAR $FOLDERS $FILES

cat $SELF_EXTRACTING_SCRIPT $TAR > $EXEC
chmod a+x $EXEC 

rm $TAR
