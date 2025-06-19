@echo off
setlocal enabledelayedexpansion

:: Check if download path is provided
if "%~1"=="" (
    echo No download path specified.
    exit /b
)

:: Check if the download path exists
if not exist "%~1" (
    echo The specified download path does not exist.
    exit /b
)

:: === Try to save image from clipboard ===
echo Checking for image in clipboard...
for /f %%A in ('powershell -nologo -command "Get-Date -Format yyyyMMdd_HHmmss"') do set "STAMP=%%A"
set "OUTFILE=%~1\clipboard_image_%STAMP%.png"

powershell -nologo -command ^
 "try { $img = Get-Clipboard -Format Image -ErrorAction Stop; if ($img) { $img.Save('%OUTFILE%', [System.Drawing.Imaging.ImageFormat]::Png); Write-Output 'Saved to %OUTFILE%' } else { Write-Output 'Clipboard does not contain an image.'; exit 1 } } catch { Write-Output 'Clipboard does not contain an image.'; exit 1 }"

if exist "%OUTFILE%" (
    echo Image saved to: %OUTFILE%
    exit /b
)

:: === If not an image, try URL ===

:: Get URL from clipboard using PowerShell
for /f "tokens=* usebackq" %%A in (`powershell -command "Get-Clipboard"`) do set "URL=%%A"

:: Check if URL was extracted
if "%URL%"=="" (
    echo Clipboard is empty or does not contain a URL.
    exit /b
)

:: Define paths to yt-dlp, wget, and video.txt
set "YTDLP=%~dp0yt-dlp.exe"
set "WGET=%~dp0wget.exe"
set "VIDEO_LIST=%~dp0video.txt"

:: Check if yt-dlp exists
if not exist "%YTDLP%" (
    echo yt-dlp.exe not found in the script directory.
    exit /b
)

:: Check if wget exists
if not exist "%WGET%" (
    echo wget.exe not found in the script directory.
    exit /b
)

:: Check if video.txt exists
if not exist "%VIDEO_LIST%" (
    echo video.txt not found in the script directory.
    exit /b
)

:: Check if the URL matches any video site from video.txt
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
    echo Video site detected. Using yt-dlp...
    "%YTDLP%" -f "bestvideo+bestaudio/best" --concurrent-fragments 10 --merge-output-format mp4 -o "%~1\%%(title)s-%%(id)s.%%(ext)s" "!URL!"
) else (
    echo Non-video site detected. Using wget...
    "%WGET%" -P "%~1" "!URL!"
)

exit /b
