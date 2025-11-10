# Bandit Level 1 → Level 2

**Goal:** The password for the next level is stored in a file called `-` located in the home directory.

---

### 🧰 Commands used

```bash
ls -la
cat ./-
# -> PASSWORD_REDACTED


💡 What I learned
How to handle special filenames that look like command options (like -).

Using ./ to tell the shell to look for the file in the current directory.
