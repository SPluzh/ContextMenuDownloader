@echo off
setlocal

:: Path to download_to_folder.bat (next to this script)
set "BAT_PATH=%~dp0download_to_folder.bat"

:: Path to the icon (next to this script)
set "ICON_PATH=%~dp0download.ico"

:: Check if download_to_folder.bat exists
if not exist "%BAT_PATH%" (
    echo download_to_folder.bat not found next to this script.
    exit /b
)

:: Check if download.ico exists
if not exist "%ICON_PATH%" (
    echo download.ico not found next to this script.
    exit /b
)

:: Add "Download to Current Folder" entry to the context menu for directories (Shift+Right-Click only)
echo Adding "Download to Current Folder" with an icon (Shift+Right-Click only)...
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\DownloadHere" /ve /t REG_SZ /d "Download Here" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\DownloadHere" /v "Icon" /t REG_SZ /d "%ICON_PATH%" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\DownloadHere" /v "Extended" /t REG_NONE /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\DownloadHere\command" /t REG_SZ /d "\"%BAT_PATH%\" \"%%V\"" /f

echo "Download to Current Folder" entry successfully added (Shift+Right-Click only).
pause
