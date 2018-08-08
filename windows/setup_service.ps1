# Install the Windows Subsystem for Linux
#   https://docs.microsoft.com/en-us/windows/wsl/install-win10 )
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# stop SuperFetch
Stop-Service -Force -Name "SysMain"; Set-Service -Name "SysMain" -StartupType Disabled
