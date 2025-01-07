# Context Menu Downloader

This project adds a **"Download Here"** option to the Windows Explorer context menu. It enables users to download files from URLs stored in the clipboard using `wget` or `yt-dlp`, depending on the type of link.

---

## Features

- Downloads files using `wget` or `yt-dlp`.
- Automatically detects video links (e.g., YouTube, Vimeo) and uses `yt-dlp` for downloading.
- Supports high-quality video and audio downloads in MP4 format.
- Automatically merges video and audio streams if necessary using **FFmpeg**.
- Context menu integration for easy usage.
- Custom icon (`download.ico`) for the context menu option.

---

## Prerequisites

1. **Install Dependencies:**
   - Run `download_dependencies.bat` to automatically download and extract `wget`, `yt-dlp`, and `FFmpeg`.
   - Alternatively, manually download and install the following tools:
     - [wget](https://eternallybored.org/misc/wget/) - Command-line file downloader.
     - [yt-dlp](https://github.com/yt-dlp/yt-dlp/releases) - Advanced YouTube downloader.
     - [FFmpeg](https://ffmpeg.org/download.html) - Required for merging video and audio streams.  
       - Ensure `ffmpeg.exe` is available in your system's PATH or placed in the same directory as the script.

2. **Ensure the following files are in the same folder:**
   - `download_to_folder.bat`
   - `add_context_menu.bat` (for adding the context menu entry).
   - `add_shift_context_menu.bat` (for adding the "Download Here" option with Shift).
   - `remove_context_menu.bat` (for removing the context menu entry).
   - `video.txt` (to define sites handled by `yt-dlp`).
   - `download.ico` (icon used for the context menu option).
   - `update_yt-dlp.bat` (for updating `yt-dlp`).

---

## Installation

1. **Clone or Download This Repository:**
   - Clone the repository:
     ```bash
     git clone https://github.com/SPluzh/ContextMenuDownloader.git
     ```
   - Or download the ZIP file and extract it.

2. **Install Dependencies:**
   - Run `download_dependencies.bat` to download and set up `wget`, `yt-dlp`, and `FFmpeg`.

3. **Add to the Context Menu:**
   - Run `add_context_menu.bat` to add the **"Download Here"** option.  
     **Note:** These actions may require administrator privileges.  
     - **Recommendation for Windows 11:** Using the Shift+Right-Click option (`add_shift_context_menu.bat`) is recommended, as the standard context menu in Windows 11 is simplified and may hide additional entries.

4. **Edit `video.txt`:**
   - Open `video.txt` with a text editor.
   - Add domains (one per line) for sites to be handled by `yt-dlp` (e.g., `youtube.com`, `vimeo.com`).

---

## Usage

1. **Copy a URL to the Clipboard:**
   - Copy any file URL (e.g., a direct download link or video URL).

2. **Right-Click in the Desired Folder:**
   - If you installed the context menu using `add_context_menu.bat`, simply right-click in the folder where you want to save the file.  
   - If you used `add_shift_context_menu.bat`, hold the `Shift` key, then right-click in the folder where you want to save the file.

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
     **Note:** These actions may require administrator privileges.

2. **Remove Shift+Right-Click Option (Optional):**
   - If you added the **"Download Here"** option with `Shift`, run `remove_shift_context_menu.bat`.
     **Note:** These actions may require administrator privileges.

3. **Delete the Scripts:**
   - Delete the downloaded folder and all associated files.

---

## Notes

- **Supported Video Formats:**
  - Videos are downloaded in the best available quality and merged into MP4 format whenever possible.

- **Updating Tools:**
  - If downloading videos stops working, update `yt-dlp` by running the `update_yt-dlp.bat` file.

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

```plaintext
ContextMenuDownloader/
├── download_to_folder.bat
├── wget.exe
├── yt-dlp.exe
├── ffmpeg.exe
├── video.txt
├── add_context_menu.bat
├── add_shift_context_menu.bat
├── remove_context_menu.bat
├── download.ico
├── update_yt-dlp.bat
└── download_dependencies.bat
```

---

## License

This project is licensed under the MIT License. Feel free to modify and distribute it.

---
