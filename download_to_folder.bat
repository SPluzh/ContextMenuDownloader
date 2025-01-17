@echo off
setlocal enabledelayedexpansion

:: Check if the download path is provided
if "%~1"=="" (
    echo No download path specified.
    exit /b
)

:: Get URL from clipboard using PowerShell
for /f "tokens=* usebackq" %%A in (`powershell -command "Get-Clipboard"`) do set "URL=%%A"

:: Check if URL was extracted
if "%URL%"=="" (
    echo Clipboard is empty or does not contain a URL.
    exit /b
)

:: Check if the specified download path exists
if not exist "%~1" (
    echo The specified download path does not exist.
    exit /b
)

:: Paths to yt-dlp and wget (they should be next to the .bat file)
set "YTDLP=%~dp0yt-dlp.exe"
set "WGET=%~dp0wget.exe"
set "VIDEO_LIST=%~dp0video.txt"

:: Check if yt-dlp exists
if not exist "%YTDLP%" (
    echo yt-dlp.exe not found next to the .bat file.
    exit /b
)

:: Check if wget exists
if not exist "%WGET%" (
    echo wget.exe not found next to the .bat file.
    exit /b
)

:: Check if video.txt exists
if not exist "%VIDEO_LIST%" (
    echo video.txt not found next to the .bat file.
    exit /b
)

:: Read video.txt and check if the URL matches any entry
set "USE_YTDLP=false"
for /f "usebackq delims=" %%A in ("%VIDEO_LIST%") do (
    echo Checking site: %%A
    echo "!URL!" | findstr /i "%%A" >nul
    if !errorlevel! equ 0 (
        set "USE_YTDLP=true"
        goto UseYT
    )
)

:UseYT
if "%USE_YTDLP%"=="true" (
    echo Updating yt-dlp to the latest version...
    "%YTDLP%" -U
    if %ERRORLEVEL%==0 (
       echo yt-dlp successfully updated!
    ) else (
       echo Failed to update yt-dlp. Please check your internet connection or installation.
    )
    :: Use yt-dlp for matching URLs
    echo Video site detected. Using yt-dlp...
    "%YTDLP%" -f "bestvideo+bestaudio/best" --concurrent-fragments 10 --merge-output-format mp4 -o "%~1\%%(title)s.%%(ext)s" "!URL!"
) else (
    :: Use wget for other URLs
    echo Non-video site detected. Using wget...
    "%WGET%" -P "%~1" "!URL!"
)

:: Close the window after downloading