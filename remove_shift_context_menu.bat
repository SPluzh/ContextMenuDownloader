@echo off
setlocal

:: Remove the "Download to Current Folder" entry from the context menu
echo Removing "Download to Current Folder" from the context menu...
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\DownloadHere" /f

echo "Download to Current Folder" entry successfully removed.
pause
