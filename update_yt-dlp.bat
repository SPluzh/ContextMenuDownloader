@echo off
cd /d "%~dp0"
echo Updating yt-dlp to the latest version...
yt-dlp.exe -U
if %ERRORLEVEL%==0 (
    echo yt-dlp successfully updated!
) else (
    echo Failed to update yt-dlp. Please check your internet connection or installation.
)
pause
