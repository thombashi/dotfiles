#!/usr/bin/env sh

joe g linux,windows,macos,microsoftoffice,eclipse,visualstudiocode > .gitignore_global
echo "
#### User Settings ####
.ipynb_checkpoints/
.pytest_cache/

.gitconfig.private
.python-version

_trash/
_TRASH/
_sandbox/
_SANDBOX/

upgrade.sh
release.sh
" >> .gitignore_global
