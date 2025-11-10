#!/usr/bin/env bash
set -e

# --- This script is set for level-1-to-2 ---
LEVEL="1-to-2"
# ------------------------------------------

OUTDIR="$HOME/bandit-levels/assets/thumbnails"
OUTFILE="$OUTDIR/level-$LEVEL.png"
README_FILE="$HOME/bandit-levels/level-$LEVEL/README.md"
TMPTXT="/tmp/bandit_cmds.txt"
TMPHTML="/tmp/bandit_cmds.html"

# Ensure the output directory exists
mkdir -p "$OUTDIR"

echo "Converting your text file ($TMPTXT) to an image..."

# 1) Convert to HTML using aha (install if needed)
if ! command -v aha >/dev/null 2>&1; then
  echo "Installing 'aha' (ANSI to HTML converter)..."
  sudo apt update
  sudo apt install -y aha
fi
aha < "$TMPTXT" > "$TMPHTML"

# 2) Render HTML to PNG using a headless browser
if command -v firefox >/dev/null 2>&1; then
  echo "Rendering PNG with headless Firefox..."
  firefox --headless --screenshot="$OUTFILE" "file://$TMPHTML" || true
elif command -v chromium >/dev/null 2>&1 || command -v chromium-browser >/dev/null 2>&1; then
  CHROMEBIN="$(command -v chromium || command -v chromium-browser)"
  echo "Rendering PNG with headless Chromium..."
  "$CHROMEBIN" --headless --disable-gpu --screenshot="$OUTFILE" --window-size=1200,900 "file://$TMPHTML" || true
else
  echo "No headless browser found. Please open $TMPHTML in your browser and take a screenshot manually."
  exit 1
fi

# 3) Verify output
if [ ! -f "$OUTFILE" ]; then
    echo "Failed to create PNG. Please open $TMPHTML in a browser and take a manual screenshot."
    exit 1
fi
echo "✅ Screenshot saved to: $OUTFILE"

# 4) Commit and push to git repo
cd "$HOME/bandit-levels" || exit
git add "$OUTFILE"
# Also add the README in case it wasn't added yet
if [ -f "$README_FILE" ]; then
    git add "$README_FILE"
fi

read -p "Ready to git commit & push screenshot? (y/n): " RESP
if [ "$RESP" = "y" ] || [ "$RESP" = "Y" ]; then
  git commit -m "Add screenshot for level-$LEVEL" || echo "Nothing new to commit."
  git push
  echo "🎉 Pushed to GitHub!"
else
  echo "Skipped git push. Your screenshot is saved locally."
fi

echo "All done."
