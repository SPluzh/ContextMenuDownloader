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

:: Define paths to tools and site lists
set "YTDLP=%~dp0yt-dlp.exe"
set "WGET=%~dp0wget.exe"
set "GALLERYDL=%~dp0gallery-dl.exe"
set "YT-DLP_LIST=%~dp0yt-dlp.txt"
set "GALLERYDL_LIST=%~dp0gallery-dl.txt"
set "IG_COOKIES=%~dp0ig_cookies.txt"

:: Check required tools
if not exist "%YTDLP%" (
    echo yt-dlp.exe not found in the script directory.
    exit /b
)
if not exist "%WGET%" (
    echo wget.exe not found in the script directory.
    exit /b
)
if not exist "%GALLERYDL%" (
    echo gallery-dl.exe not found in the script directory.
    exit /b
)

:: === Check yt-dlp sites ===
set "USE_YTDLP=false"
if exist "%YT-DLP_LIST%" (
    for /f "usebackq delims=" %%A in ("%YT-DLP_LIST%") do (
        echo Checking yt-dlp site: %%A
        echo "!URL!" | findstr /i "%%A" >nul
        if !errorlevel! equ 0 (
            set "USE_YTDLP=true"
            goto UseYT
        )
    )
)

:: === Check gallery-dl sites ===
set "USE_GALLERYDL=false"
if exist "%GALLERYDL_LIST%" (
    for /f "usebackq delims=" %%A in ("%GALLERYDL_LIST%") do (
        echo Checking gallery-dl site: %%A
        echo "!URL!" | findstr /i "%%A" >nul
        if !errorlevel! equ 0 (
            set "USE_GALLERYDL=true"
            goto UseGalleryDL
        )
    )
)

:: === Default to wget ===
echo Non-video and non-gallery site detected. Using wget...
"%WGET%" -P "%~1" "!URL!"
exit /b

:UseYT
echo Updating yt-dlp to the latest version...
"%YTDLP%" -U
if %ERRORLEVEL%==0 (
    echo yt-dlp successfully updated!
) else (
    echo Failed to update yt-dlp. Please check your internet connection or installation.
)
echo Video site detected. Using yt-dlp...
"%YTDLP%" -f "bestvideo+bestaudio/best" --concurrent-fragments 10 --merge-output-format mp4 -o "%~1\%%(title)s-%%(id)s.%%(ext)s" "!URL!"
exit /b

:UseGalleryDL
echo Gallery site detected. Using gallery-dl...
"%GALLERYDL%" --cookies "%IG_COOKIES%" --directory "" --filename "{date}_{username}_{shortcode}_{num}.{extension}" -d "%~1" "!URL!"
exit /b
