# Context Menu Downloader

This project adds a **"Download Here"** option to the Windows Explorer context menu. It enables users to download files from URLs stored in the clipboard using `wget` or `yt-dlp`, depending on the type of link.  
It also supports saving **images directly from the clipboard** as PNG files.

https://github.com/user-attachments/assets/aed905af-ac00-4930-a244-37fc3195c897

---

## Features

- Downloads regular files using `wget`
- Detects video sites (e.g. YouTube, TikTok) and uses `yt-dlp`
- Detects gallery/image hosting sites (e.g. Instagram, Pixiv) and uses `gallery-dl`
- Supports authenticated Instagram downloads via `ig_cookies.txt`
- Saves clipboard images as timestamped `.png` files
- Allows commenting and skipping empty lines in `yt-dlp.txt` and `gallery-dl.txt`
- Disables nested folders for Instagram downloads (files go directly into the selected folder)
- Context menu integration with icon and optional Shift+Right-Click support
- Automatically updates `yt-dlp` before use

## Prerequisites

1. **Install Dependencies:**
   - Run `download_dependencies.bat` to automatically download and extract:
     - `wget.exe` — command-line file downloader
     - `yt-dlp.exe` — advanced video downloader
     - `ffmpeg.exe` — for merging video and audio
     - `gallery-dl.exe` — for downloading from gallery/image sites

2. **Ensure the following files are in the same folder:**
   - `download_to_folder.bat` — main script
   - `yt-dlp.txt` — list of domains handled by `yt-dlp`
   - `gallery-dl.txt` — list of domains handled by `gallery-dl`
   - `ig_cookies.txt` — optional, for downloading from Instagram with authentication
   - `add_context_menu.bat` — adds the context menu entry
   - `add_shift_context_menu.bat` — adds Shift+Right-Click menu (Windows 11 friendly)
   - `remove_context_menu.bat` — removes the context menu entry
   - `download.ico` — icon used in the context menu
   - `update_yt-dlp.bat` — updates `yt-dlp` to the latest version
   - `update_gallery-dl.bat` — updates `gallery-dl` to the latest version

---

## Installation

1. **Clone or Download This Repository:**
   - Clone the repository:
     ```bash
     git clone https://github.com/SPluzh/ContextMenuDownloader.git
     ```
   - Or download the ZIP file and extract it.

2. **Install Dependencies:**
   - Run `download_dependencies.bat` to download and set up the required tools:
     - `wget`
     - `yt-dlp`
     - `gallery-dl`
     - `FFmpeg`

3. **Add to the Context Menu:**
   - Run `add_context_menu.bat` to add the **"Download Here"** option.
     > ⚠️ These actions may require administrator privileges.
   - **Windows 11 users:** We recommend using `add_shift_context_menu.bat`, which adds the option to the classic Shift+Right-Click context menu (since newer Windows versions hide extended items by default).

4. **Configure Site Match Lists:**
   - Open `yt-dlp.txt` to list domains for video sites handled by `yt-dlp` (e.g. `youtube.com`, `tiktok.com`).
   - Open `gallery-dl.txt` to list domains for gallery/image sites handled by `gallery-dl` (e.g. `instagram.com`, `pixiv.net`).
   - Each file supports:
     - One domain per line
     - Empty lines (ignored)

5. **(Optional) Instagram Cookies for Private Content:**
   - To download from private or logged-in Instagram content (e.g., stories, private profiles), you need to export your session cookies.
   - Use a browser extension like:
     - [Get cookies.txt](https://chrome.google.com/webstore/detail/get-cookiestxt/lijplcijljnlogcmoafhpaiggglikgdd) (for Chrome/Chromium-based browsers)
     - [cookies.txt](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/) (for Firefox)
   - Steps:
     1. Log into your Instagram account in your browser.
     2. Open the extension and export cookies for `instagram.com`.
     3. Save the exported file as `ig_cookies.txt` in the same folder as the script.
   - The script will automatically use this file when downloading with `gallery-dl`.


---

## Usage

1. **Copy a URL or Image to the Clipboard:**
   - You can copy:
     - A direct file URL (e.g. image, PDF, zip, etc.)
     - A video URL (e.g. YouTube, TikTok, Vimeo, etc.)
     - A post URL from gallery sites (e.g. Instagram, Pixiv)
     - Or an actual image (e.g. from browser, screenshot tool, or image viewer)

2. **Right-Click in the Desired Folder:**
   - If you installed the context menu using `add_context_menu.bat`, right-click in the target folder.
   - If you used `add_shift_context_menu.bat`, hold the `Shift` key and right-click to see the **"Download Here"** option (recommended for Windows 11).

3. **Select "Download Here":**
   - If the clipboard contains an image:
     - It will be saved as a `.png` file with a timestamped filename (e.g. `clipboard_image_20240628_143001.png`)
   - If the clipboard contains a URL:
     - If the URL matches any domain listed in `yt-dlp.txt`, `yt-dlp` will be used to download the video.
       - The tool will automatically update itself before use.
       - Output will be saved in the best available format (usually `.mp4`)
     - If the URL matches any domain listed in `gallery-dl.txt`, `gallery-dl` will be used to download media.
       - If `ig_cookies.txt` is present and the site is Instagram, it will be used to access private content.
       - Files will be saved directly to the folder without nested subdirectories.
     - Otherwise, `wget` will be used to download the file as-is.

    
https://github.com/user-attachments/assets/68aad1c1-f733-4450-8bf2-d26e6e614202

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
  - Videos are downloaded using `yt-dlp` in the best available quality.
  - Video and audio streams are automatically merged into `.mp4` using `ffmpeg`, when needed.

- **Image and Gallery Support:**
  - `gallery-dl` is used for sites like Instagram, Pixiv, and DeviantArt.
  - Files are saved directly to the selected folder without extra subfolders.
  - Instagram downloads support private content if `ig_cookies.txt` is available.

- **Updating Tools:**
  - If `yt-dlp` stops working (e.g., format error or unsupported site), run `update_yt-dlp.bat` to get the latest version.
  - To update `gallery-dl`, run `update_gallery-dl.bat`.

- **Clipboard Images:**
  - If the clipboard contains an image, it will be saved as a `.png` file with a timestamped name (e.g. `clipboard_image_20240628_143001.png`).

- **Cookie Authentication:**
  - To download private Instagram posts, export cookies using a browser extension and save them as `ig_cookies.txt` (see instructions above).

- **Context Menu Icon:**
  - The context menu entry displays a custom icon (`download.ico`) for easier identification.

---

## File Structure

Here’s the recommended folder structure:

```plaintext
ContextMenuDownloader/
├── download_to_folder.bat
├── yt-dlp.txt
├── gallery-dl.txt
├── ig_cookies.txt
├── yt-dlp.exe
├── wget.exe
├── ffmpeg.exe
├── gallery-dl.exe
├── download.ico
├── add_context_menu.bat
├── add_shift_context_menu.bat
├── remove_context_menu.bat
├── download_dependencies.bat
├── update_yt-dlp.bat
├── update_gallery-dl.bat
└── README.md
```

---

## License

This project is licensed under the MIT License. Feel free to modify and distribute it.

---
