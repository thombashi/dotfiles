#!/usr/bin/env sh

\cp -fva --backup --update .nanorc "${HOME}/.nanorc"

curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
