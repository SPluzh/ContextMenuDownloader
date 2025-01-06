# Context Menu Downloader

This project adds a **"Download Here"** option to the Windows Explorer context menu. It enables users to download files from URLs stored in the clipboard using `wget` or `yt-dlp`, depending on the type of link.
[!Watch the video example](https://github.com/user-attachments/assets/9e4dfbb1-bf29-42f2-bd08-088133950d0f)

## Features

- Downloads files using `wget` or `yt-dlp`.
- Automatically detects video links (e.g., YouTube, Vimeo) and uses `yt-dlp` for downloading.
- Supports high-quality video and audio downloads in MP4 format.
- Automatically merges video and audio streams if necessary using **FFmpeg**.
- Context menu integration for easy usage.
- Custom icon for the context menu option.

---

## Prerequisites

1. **Install Dependencies:**
   - Instead of manually downloading dependencies, you can run the `download_dependencies.bat` file to automatically download and extract `wget`, `yt-dlp`, and `FFmpeg`.
   - Alternatively, manually download and install the following tools:
     - [wget](https://eternallybored.org/misc/wget/) - Command-line file downloader.
     - [yt-dlp](https://github.com/yt-dlp/yt-dlp/releases) - Advanced YouTube downloader.
     - [FFmpeg](https://ffmpeg.org/download.html) - Required for merging video and audio streams.  
       - Ensure `ffmpeg.exe` is available in your system's PATH or placed in the same directory as the script.

2. **Ensure the following files are in the same folder:**
   - `download_to_folder.bat`
   - `context_menu_add.reg` (for adding the context menu entry).
   - `context_menu_remove.reg` (for removing the context menu entry).
   - `add_shift_context_menu.bat` (for adding the "Download Here" option with Shift).
   - `remove_shift_context_menu.bat` (for removing the "Download Here" option with Shift).
   - `video.txt` (to define sites handled by `yt-dlp`).
   - `download.ico` (icon used for the context menu option).

---

## Installation

1. **Clone or Download This Repository:**
   - Clone the repository:
     ```bash
     git clone https://github.com/SPluzh/ContextMenuDownloader.git
     ```
   - Or download the ZIP file and extract it.

2. **Install Dependencies:**
   - Run the `download_dependencies.bat` file to automatically download and extract `wget`, `yt-dlp`, and `FFmpeg` in the current directory.

3. **Add to the Context Menu:**
   - Double-click the `add_context_menu.bat` file to add the **"Download Here"** option.
   - Confirm the changes when prompted.

4. **Add Shift+Right-Click Option (Optional):**
   - If you want the **"Download Here"** option to appear when holding the `Shift` key, run `add_shift_context_menu.bat`.

5. **Edit `video.txt`:**
   - Open `video.txt` with a text editor.
   - Add domains (one per line) for sites to be handled by `yt-dlp` (e.g., `youtube.com`, `vimeo.com`).

---

## Usage

1. **Copy a URL to the Clipboard:**
   - Copy any file URL (e.g., a direct download link or video URL).

2. **Right-Click in the Desired Folder:**
   - Hold the `Shift` key, then right-click in the folder where you want to save the file.

3. **Select "Download Here":**
   - The script will automatically:
     - Use `wget` for regular file downloads.
     - Use `yt-dlp` for video links in `video.txt`.

4. **Output File Naming:**
   - Regular files: The file retains its original name.
   - Videos: Files are named using the video's title (`%(title)s.%(ext)s`).

---

## Uninstallation

1. **Remove the Context Menu Entry:**
   - Double-click the `remove_context_menu.bat` file to remove the **"Download Here"** option.

2. **Remove Shift+Right-Click Option (Optional):**
   - If you added the **"Download Here"** option with `Shift`, run `remove_shift_context_menu.bat`.

3. **Delete the Scripts:**
   - Delete the downloaded folder and all associated files.

---

## Notes

- **Supported Video Formats:**
  - Videos are downloaded in the best available quality and merged into MP4 format whenever possible.
  
- **Updating Tools:**
  - Keep `yt-dlp` up-to-date by running the `update_yt-dlp.bat` file to automatically update `yt-dlp`.

- **Troubleshooting:**
  - If downloads fail, check for available formats with:
    ```cmd
    yt-dlp.exe --list-formats <URL>
    ```

- **FFmpeg Path:**
  - Ensure `ffmpeg.exe` is correctly installed or included in the same directory as the script for merging video and audio.

- **Context Menu Icon:**
  - The context menu option is accompanied by a custom icon, `download.ico`, which will be shown next to the "Download Here" entry.

---

## File Structure

Here’s the recommended folder structure:


ContextMenuDownloader/ 
   - download_to_folder.bat # Main script for downloading files 
   - wget.exe # wget executable for downloading files 
   - yt-dlp.exe # yt-dlp executable for downloading videos 
   - ffmpeg.exe # FFmpeg executable for merging video and audio 
   - video.txt # List of video websites for yt-dlp 
   - context_menu_add.reg # Registry file to add the context menu option 
   - context_menu_remove.reg # Registry file to remove the context menu option 
   - add_shift_context_menu.bat # Adds "Download Here" with Shift+Right-Click 
   - remove_shift_context_menu.bat # Removes "Download Here" with Shift+Right-Click 
   - download.ico # Custom icon for the context menu option 
   - update_yt-dlp.bat # Updates yt-dlp to the latest version

---

## License

This project is licensed under the MIT License. Feel free to modify and distribute it.

---
