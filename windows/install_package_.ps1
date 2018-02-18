# Script to install Windows packages via chocolatey
Start-Process choco -Verb runas -Wait -ArgumentList "install packages.config -y"
