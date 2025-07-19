clipboard() {
    if [ -t 0 ]; then
        # No stdin pipe, so output clipboard content
        pbpaste
    else
        # Stdin pipe exists, so copy to clipboard
        pbcopy
    fi
}


# Zsh function to download a video from a URL in the clipboard using yt-dlp and Firefox cookies.
#
# USAGE:
#   ytdl-ff
#
# DESCRIPTION:
#   This function retrieves the URL currently in the system clipboard,
#   then invokes yt-dlp to download the content from that URL.
#   It uses the '--cookies-from-browser' flag to access Firefox's cookies,
#   which is useful for downloading content from sites that require a login.
#
# REQUIREMENTS:
#   - yt-dlp: A powerful command-line video downloader.
#     (Install with Homebrew: `brew install yt-dlp`)
#   - Firefox: Must be installed on the system.

#echo ytcb
ytcb() {
  # Check if yt-dlp is installed
  if ! command -v yt-dlp &> /dev/null; then
    echo "Error: yt-dlp is not installed."
    echo "Please install it, for example with Homebrew: brew install yt-dlp"
    return 1
  fi

  # Get the URL from the macOS clipboard
  local url
  url=$(pbpaste)

  # Validate if the clipboard content is a URL (simple check)
  if [[ -z "$url" || ! "$url" =~ ^https?:// ]]; then
    echo "Error: No valid URL found in the clipboard."
    echo "Clipboard content: '$url'"
    return 1
  fi

  echo "Starting download for URL: $url"
  echo "Using cookies from Firefox..."

  # Run yt-dlp with the URL from the clipboard and Firefox cookies
  # The command will be executed in the current directory.
  yt-dlp --cookies-from-browser firefox "$url"
}
