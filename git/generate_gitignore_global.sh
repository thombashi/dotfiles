#!/usr/bin/env sh

joe g linux,windows,macos,microsoftoffice,eclipse,visualstudiocode > .gitignore_global
echo "
#### User Settings ####
.ipynb_checkpoints/
.pytest_cache/

.gitconfig.private
.python-version

_sandbox/
_SANDBOX/
_todo/
_TODO/
_trash/
_TRASH/

upgrade.sh
release.sh
" >> .gitignore_global
