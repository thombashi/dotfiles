# dotfiles for Windows

# Install Windows packages via choco
```
> Set-ExecutionPolicy RemoteSigned -Scope Process -Force; ./install_package_.ps1
```

# Upgrade packages
```
> Start-Process cup -Verb runas -Wait -ArgumentList all
```

# List installed packages
```
> choco list --local-only
```

# Dependencies
- [Chocolatey - The package manager for Windows](https://chocolatey.org/)
