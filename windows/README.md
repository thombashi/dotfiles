# dotfiles for Windows

# Install Windows packages via choco
```ps1
> Set-ExecutionPolicy Unrestricted -Scope Process -Force; ./install_package_.ps1
```

# Upgrade packages
```ps1
> Start-Process cup -Verb runas -Wait -ArgumentList all
```

# List installed packages
```ps1
> choco list --local-only
```

# Dependencies
- [Chocolatey - The package manager for Windows](https://chocolatey.org/)
