#!/usr/bin/env sh

# make a directory for backup
\mkdir -p "${HOME}/.nano_bkp"

\cp -fva --backup --update .nanorc "${HOME}/.nanorc"

curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
