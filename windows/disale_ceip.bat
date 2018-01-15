@echo off

REM  A bat file to disable Microsoft Compatibility Telemetry

schtasks /End /TN "\Microsoft\Windows\Application Experience\AitAgent"
schtasks /Change /TN "\Microsoft\Windows\Application Experience\AitAgent" /DISABLE

schtasks /End /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE

schtasks /End /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE

pause
