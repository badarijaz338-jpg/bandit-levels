# OverTheWire: Bandit Wargames (Automated) 🐧

A personal record of my progress through the [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) wargames. 

**Current Progress:** Levels 0 → 10

## 🚀The Project Goal
The goal isn't just to capture flags; it's to build a **reproducible, automated workflow** for documenting cybersecurity findings. Instead of manually taking screenshots and copying text, I built a Bash-based pipeline to handle the documentation.

---

## 🛠️ The Automation Workflow
I created a custom script (`make_screenshot.sh`) that turns terminal output into high-quality visual assets for this repository.

### How it works:
1. **Input:** The script reads a temporary file (`/tmp/bandit_cmds.txt`) containing the sanitized command history used to solve the level.
2. **ANSI Conversion:** It checks for **`aha`** (Ansi HTML Adapter). If missing, it installs it. It then converts the terminal text (colors included) into raw HTML.
3. **Headless Rendering:** The script detects an installed browser (Firefox or Chromium) and launches it in **headless mode**. It renders the HTML file and captures a screenshot programmatically.
4. **Git Integration:** The script automatically moves the asset to the correct folder, stages the files, and prompts for a Git push.

### The Tech Stack
* **Linux/Bash:** For the core logic and file management.
* **Aha:** For parsing ANSI escape codes to HTML.
* **Headless Firefox/Chromium:** For automated image generation.
* **Git:** For version control.

---

## 📂 Repository Structure

```text
bandit-levels/
├── assets/
│   └── thumbnails/    # Automatically generated screenshots of terminal history
├── level-0-to-1/      # Write-up for Level 0 -> 1
├── level-1-to-2/      # Write-up for Level 1 -> 2
├── ...
└── make_screenshot.sh # The automation script



# Disclaimer
No Passwords Included. In accordance with OverTheWire community rules, this repository contains methodologies and command logs, but actual passwords/flags for the levels are not explicitly listed in text format to preserve the challenge for others.
