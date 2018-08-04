# dotfiles for Windows


# Install Windows packages via choco
## Install packages
```ps1
> Set-ExecutionPolicy Unrestricted -Scope Process -Force; ./install_package_.ps1
```

## Upgrade packages
```ps1
> Start-Process cup -Verb runas -Wait -ArgumentList all
```

## List installed packages
```ps1
> choco list --local-only
```

## Dependencies
- [Chocolatey - The package manager for Windows](https://chocolatey.org/)


# Setup Windows Services
Open PowerShell as Administrator and run:

```ps1
> Set-ExecutionPolicy Unrestricted -Scope Process -Force; ./setup_service.ps1
```
