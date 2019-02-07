@echo off
rem npm config set msvs_version 2015
echo ==[ Install "windows-build-tools" first ]=========================
call npm install -g -production --add-python-to-path windows-build-tools
echo ==[ Install "node-gyp" ]==========================================
call npm install -g node-gyp

echo ==[ Update PATH for the current session ]=========================
echo %PATH% | findstr "python27" >nul || for /f "tokens=3* delims= " %%a in ('REG QUERY HKCU\Environment /v Path') do (echo Updating PATH variable... && @set PATH=%%a%%b && setx PATH "%%a%%b" /M)
echo PATH=%PATH%
set PATH=%PATH%
echo.
echo ==================================================================
echo Done

echo.
echo "IMPORTANT: Please restart this terminal -> close it and open new one"
