# Windows Core Tools

## Core Tools
* [Chocolatey](https://chocolatey.org) - Console package manager.
* [Notepad3](https://www.rizonesoft.com/downloads/notepad3/) - better lightweight notepad for Windows.
* [Snaketail](http://snakenest.com/snaketail/) - tail utility for monitoring growing text log files.
* [7zip](https://www.7-zip.org/) - free and open-source file archiver.
* [Google Chrome](https://www.google.com/chrome/) - browser better then Internet Explorer :)


## Linux Subsystem

[Full Instruction](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

* Open PowerShell as Administrator and run:
```powershell
# Powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
* Restart your computer when prompted.
* Download Ubuntu 18.04 distro
```powershell
# Powershell
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
```
* [Unpack and install the distro](https://docs.microsoft.com/en-us/windows/wsl/install-on-server#extract-and-install-a-linux-distro)



## Powershell

### Allow running scripts in PowerShell (Fix: Running scripts is disabled on this system)
```powershell
PS > Set-ExecutionPolicy RemoteSigned 
```

### Powershell profile

Default powershell profile location: %USERPROFILE%\Documents\WindowsPowerShell\profile.ps1
```bat
cmd /C "notepad %USERPROFILE%\Documents\WindowsPowerShell\profile.ps1"
```

profile.ps1
```powershell
# Allow all version of SSL protocols for Invoke-WebRequest method
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
# Aliases
Set-Alias -Name ll -Value ls
```

Download a file from the console:
```powershell
Invoke-WebRequest http://blog.stackexchange.com/ -UseBasicParsing -OutFile out.html
``````

## Knowledge Base
* [Windows keyboard Shortcuts](./notes/windows-shortcuts.md)
* Open startup folder in Windows 10: Open "Run" dialog (Win+R) -> Execute "shell:startup"
* Docker sometimes doesn't work on the Windows inside the Virtual Machine - [see](https://github.com/docker/for-win/issues/574#issuecomment-442661635)
