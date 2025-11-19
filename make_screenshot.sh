#!/usr/bin/env bash
set -e

# --- 1. ARGUMENT PARSING ---
# Check if the user provided a level argument.
# Usage: ./make_screenshot.sh 1-to-2
if [ -z "$1" ]; then
  echo "❌ Error: No level specified."
  echo "Usage: ./make_screenshot.sh <start-to-end>"
  echo "Example: ./make_screenshot.sh 5-to-6"
  exit 1
fi

LEVEL="$1"
# ---------------------------

# --- 2. CONFIGURATION ---
REPO_ROOT="$HOME/bandit-levels"
OUTDIR="$REPO_ROOT/assets/thumbnails"
OUTFILE="$OUTDIR/level-$LEVEL.png"
README_FILE="$REPO_ROOT/level-$LEVEL/README.md"

# The file where you paste your terminal history before running this script
TMPTXT="/tmp/bandit_cmds.txt"
TMPHTML="/tmp/bandit_cmds.html"

# Check if input file exists
if [ ! -f "$TMPTXT" ]; then
    echo "❌ Error: Input file $TMPTXT not found."
    echo "Please save your command history to $TMPTXT first."
    exit 1
fi

# Ensure the output directory exists
mkdir -p "$OUTDIR"

echo "📸 Processing screenshot for Level $LEVEL..."

# --- 3. CONVERSION (ANSI -> HTML) ---
if ! command -v aha >/dev/null 2>&1; then
  echo "Installing 'aha' (ANSI to HTML converter)..."
  sudo apt update && sudo apt install -y aha
fi

echo "Converting text to HTML..."
aha < "$TMPTXT" > "$TMPHTML"

# --- 4. RENDERING (HTML -> PNG) ---
if command -v firefox >/dev/null 2>&1; then
  echo "rendering PNG with headless Firefox..."
  # Firefox headless screenshot
  firefox --headless --screenshot="$OUTFILE" "file://$TMPHTML" || true
  
elif command -v chromium >/dev/null 2>&1 || command -v chromium-browser >/dev/null 2>&1; then
  CHROMEBIN="$(command -v chromium || command -v chromium-browser)"
  echo "Rendering PNG with headless Chromium..."
  # Chromium headless screenshot
  "$CHROMEBIN" --headless --disable-gpu --screenshot="$OUTFILE" --window-size=1200,900 "file://$TMPHTML" || true

else
  echo "❌ Error: No headless browser found (Firefox or Chromium)."
  echo "Please install a browser or take the screenshot manually."
  exit 1
fi

# --- 5. VERIFICATION ---
if [ ! -f "$OUTFILE" ]; then
    echo "❌ Failed to create PNG."
    exit 1
fi
echo "✅ Screenshot saved successfully: $OUTFILE"

# --- 6. GIT AUTOMATION ---
cd "$REPO_ROOT" || exit

# Stage the new screenshot
git add "$OUTFILE"

# Stage the README for this level if it exists
if [ -f "$README_FILE" ]; then
    echo "Found README for this level, staging it..."
    git add "$README_FILE"
else
    echo "⚠️  Warning: No README found at $README_FILE (proceeding anyway)"
fi

# --- 7. PUSH PROMPT ---
echo "------------------------------------------------"
git status --short
echo "------------------------------------------------"
read -p "Ready to commit & push changes for Level $LEVEL? (y/n): " RESP

if [ "$RESP" = "y" ] || [ "$RESP" = "Y" ]; then
  git commit -m "Add documentation and screenshot for level-$LEVEL" || echo "Nothing new to commit."
  git push
  echo "🎉 Pushed to GitHub! Great job on Level $LEVEL."
else
  echo "🚫 Skipped git push. Files are staged locally."
fi

echo "Done."
