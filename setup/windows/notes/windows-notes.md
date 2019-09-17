# Windows notes

## Get MAC address

Settings -> Wi-Fi / Ethernet -> Hardware properties
```
ipconfig /all
```

Windows 10:
```
getmac /v
```

Powershell
```
get-netadapter
```

## Git on Windows

1. Download git from the official site: https://git-scm.com/download/win
2. Install in into the User Space: **%USERPROFILE%/AppData/Local/Programs/Git**

Using ssh key with git on Windows ([documentation](http://guides.beanstalkapp.com/version-control/git-on-windows.html)):
1. Generate key with ```puttygen.exe``` or use existed one.
2. Add key into the ```pageagent.exe```.
3. Use ```plink.exe``` as a SSH agent for the git by using a system environment variable:
```
GIT_SSH=c:\Program Files\PuTTY\plink.exe
```
4. Now you can use ```git clone git@github.com/username/project.git```


## Core tools inside the User Environment (you don't need Administration Permissions)

Add any path to system envyronment PATH varibale (in User Space, you don't need Administrators permissions):
```powershell
PS> [Environment]::SetEnvironmentVariable("Path", $env:Path+";"+"<custom directory file name>", "User")
```

### Node js
1. Download zip package: https://nodejs.org/dist/v10.16.3/node-v10.16.3-win-x64.zip
2. Extract everything from the package into the "%APPDATA%\node" directory.
     You should have node.exe on the path: C:\Users\john\AppData\Roaming\node\node.exe
3. Open PowerShell and execute command:
    [Environment]::SetEnvironmentVariable("Path", $env:Path+";"+$env:APPDATA+"\node", "User")
4. Reopen all terminals (cmd and powershell) and execute a commands:
    node --version
    npm --version
5. Done

### Midnight commander
1. Download package: https://sites.google.com/site/revgen/storage/tools/win64-mc.zip
    original package: https://downloads.sourceforge.net/project/mcwin32/mcwin32-build204-bin.zip
2. Extract everything from the package into the "%APPDATA%\mc" directory.
     You should have mc.exe on the path: C:\Users\john\AppData\Roaming\mc\mc.exe
3. Open PowerShell and execute command:
    [Environment]::SetEnvironmentVariable("Path", $env:Path+";"+$env:APPDATA+"\mc", "User")
4. Reopen all terminals (cmd and powershell) and execute a commands:
    mc --version
5. Done

### Notepad2
1. Download package: http://www.flos-freeware.ch/zip/notepad2_4.2.25_x64.zip
2. Extract everything from the package into the "%APPDATA%\bin" directory.
     You should have notepad2.exe on the path: C:\Users\john\AppData\Roaming\bin\notepad2.exe
3. Open PowerShell and execute command:
    [Environment]::SetEnvironmentVariable("Path", $env:Path+";"+$env:APPDATA+"\bin", "User")
4. Close all terminals (cmd and powershell) and execute a commands in Run dialog:
    notepad2
5. Done

### 7zip
1. Download zip package: https://sites.google.com/site/revgen/storage/tools/win64-7zip.zip
2. Extract everything from the package into the "%APPDATA%\7zip" directory.
     You should have 7z.exe on the path: C:\Users\john\AppData\Roaming\7zip\7z.exe
3. Open PowerShell and execute command:
    [Environment]::SetEnvironmentVariable("Path", $env:Path+";"+$env:APPDATA+"\7zip", "User")
4. Reopen all terminals (cmd and powershell) and execute a commands:
    7z --help
5. Done

### Curl
1. Download zip package from: https://curl.haxx.se/windows/
    ex: https://curl.haxx.se/windows/dl-7.66.0_2/curl-7.66.0_2-win64-mingw.zip
2. Extract everything from the package into the "%APPDATA%\bin" directory.
     You should have curl.exe on the path: C:\Users\john\AppData\Roaming\bin\curl.exe
3. Open PowerShell and execute command:
    [Environment]::SetEnvironmentVariable("Path", $env:Path+";"+$env:APPDATA+"\bin", "User")
4. Reopen all terminals (cmd and powershell) and execute a commands:
    curl --version
5. Done

### wget
1. Download zip package from: https://eternallybored.org/misc/wget/releases/wget-1.20.3-win64.zip
2. Extract wget.exe  from the package into the "%APPDATA%\bin" directory.
     You should have wget.exe on the path: C:\Users\john\AppData\Roaming\bin\wget.exe
3. Open PowerShell and execute command:
    [Environment]::SetEnvironmentVariable("Path", $env:Path+";"+$env:APPDATA+"\bin", "User")
4. Reopen all terminals (cmd and powershell) and execute a commands:
    wget --version
5. Done

### SumatraPDF viewer
1. Download zip package from:https://www.sumatrapdfreader.org/downloadafter.html
2. Extract SumatraPDF.exe  from the package into the "%APPDATA%\bin" directory.
     You should have SumatraPDF.exe on the path: C:\Users\john\AppData\Roaming\bin\SumatraPDF.exe
3. Open PowerShell and execute command:
    [Environment]::SetEnvironmentVariable("Path", $env:Path+";"+$env:APPDATA+"\bin", "User")
4. Close all terminals (cmd and powershell) and execute a commands in Run dialog:
    SumatraPDF
5. Done