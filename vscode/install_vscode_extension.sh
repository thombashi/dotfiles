# Script to install extensions for code-server-server

# Install Language Extensions
## golang
code-server --force --install-extension golang.go

## Python
code-server --force --install-extension ms-python.python
code-server --force --install-extension ms-python.vscode-pylance
code-server --force --install-extension njpwerner.autodocstring

## C++
code-server --force --install-extension ms-vscode.cpptools

## Shell Script
code-server --force --install-extension timonwong.shellcheck
code-server --force --install-extension jetmartin.bats

## JavaScript
code-server --force --install-extension dbaeumer.vscode-eslint

## etc
code-server --force --install-extension bungcip.better-toml
code-server --force --install-extension yzhang.markdown-all-in-one
code-server --force --install-extension lextudio.restructuredtext
code-server --force --install-extension redhat.vscode-yaml
code-server --force vscode-icons-team.vscode-icons

# Install Application Specific Extensions
## docker
code-server --force --install-extension ms-azuretools.vscode-docker

## Git
code-server --force --install-extension eamodio.gitlens

## Jupyter Notebook
code-server --force --install-extension jithurjacob.nbpreviewer

## PlantUML
code-server --force --install-extension jebbs.plantuml
