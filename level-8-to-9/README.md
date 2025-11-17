# Bandit Level 8 → Level 9

**Goal:** The password is in `data.txt` and is the only line of text that occurs only once.

---

### 🧰 Commands used

```bash
# Sort the file and 'pipe' the result to 'uniq'
# 'uniq -u' filters for unique lines only
sort data.txt | uniq -u
# -> PASSWORD_REDACTED



💡 What I learned
How to use the sort command to order a file.

How to use the uniq -u command to find unique lines.

How to chain commands together using the pipe (|) to pass the output of one command as the input to the next.
