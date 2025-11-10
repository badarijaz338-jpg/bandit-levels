# Bandit Level 2 → Level 3

**Goal:** The password for the next level is stored in a file called `--spaces in this filename--` in the home directory.

---

### 🧰 Commands used

```bash
ls -la
cat "--spaces in this filename--"
# -> PASSWORD_REDACTED


💡 What I learned
How to handle filenames that contain spaces.

Using quotes ("...") to pass a filename with spaces as a single argument.

The difference between a file (which you cat) and a directory (which you cd).
