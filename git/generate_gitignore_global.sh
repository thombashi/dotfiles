#!/usr/bin/env sh

joe update
joe g linux,windows,macos,microsoftoffice,visualstudiocode > .gitignore_global
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

*.sqlite
*.db
upgrade.sh
" >> .gitignore_global
