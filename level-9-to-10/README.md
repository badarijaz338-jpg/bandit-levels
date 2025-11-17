# Bandit Level 9 → Level 10

**Goal:** The password is in `data.txt` and is one of the few human-readable strings, preceded by `====`.

---

### f09f9f Commands used

```bash
# 'strings' finds readable text in a binary file
# 'grep' filters for the line containing '===='
strings data.txt | grep "===="
# -> PASSWORD_REDACTED



💡 What I learned
How to use the strings command to extract readable text from data files.

Chaining strings with grep to quickly find a specific, readable password.
