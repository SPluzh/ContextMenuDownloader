@echo off
setlocal enabledelayedexpansion

:: Set the current directory to where the script is located
cd /d "%~dp0"

:: Download yt-dlp
echo Downloading yt-dlp...
curl -L -o yt-dlp.exe https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe
if %ERRORLEVEL%==0 (
    echo yt-dlp downloaded successfully!
) else (
    echo Failed to download yt-dlp.
)

:: Download FFmpeg (from the specified GitHub release)
echo Downloading FFmpeg...
curl -L -o ffmpeg.zip https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip
if %ERRORLEVEL%==0 (
    echo FFmpeg downloaded successfully!
) else (
    echo Failed to download FFmpeg.
)

:: Download wget (from the provided URL)
echo Downloading wget...
curl -L -o wget.exe https://eternallybored.org/misc/wget/1.21.4/64/wget.exe
if %ERRORLEVEL%==0 (
    echo wget downloaded successfully!
) else (
    echo Failed to download wget.
)

:: Verify FFmpeg zip file exists before extracting
if exist ffmpeg.zip (
    echo Extracting FFmpeg using system unzip...
    powershell -Command "Expand-Archive -Path 'ffmpeg.zip' -DestinationPath '.'"
    if %ERRORLEVEL%==0 (
        echo FFmpeg extracted successfully.
    ) else (
        echo Failed to extract FFmpeg using system unzip.
    )
)

:: Move ffmpeg.exe to current directory (where the script is located)
if exist "ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe" (
    echo Moving ffmpeg.exe to the current directory...
    move "ffmpeg-master-latest-win64-gpl\bin\ffmpeg.exe" .
)

:: Clean up extracted folders (delete unnecessary directories)
echo Cleaning up extracted files...
rd /s /q "ffmpeg-master-latest-win64-gpl"

:: Clean up downloaded zip file for FFmpeg
del ffmpeg.zip
echo Finished downloading all dependencies.

pause
