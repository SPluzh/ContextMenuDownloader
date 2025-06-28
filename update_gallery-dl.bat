@echo off
cd /d "%~dp0"
echo Updating gallery-dl to the latest version...

gallery-dl.exe --update

if %ERRORLEVEL%==0 (
    echo gallery-dl successfully updated!
) else (
    echo Failed to update gallery-dl. Please check your internet connection or installation.
)

pause
