# Bandit Level 6 → Level 7

**Goal:** The password is on the server, not in the home directory. Find a file that is:
1.  Owned by user `bandit7`
2.  Owned by group `bandit6`
3.  33 bytes in size

---

### 🧰 Commands used

```bash
# Find the file by searching the whole server from '/'
find / -user bandit7 -group bandit6 -size 33c 2>/dev/null

# 'find' will output the path to the file
# We 'cat' that file
cat [path-from-find-command]
# -> PASSWORD_REDACTED



💡 What I learned
How to search the entire filesystem by starting find at /.

How to find files by owner (-user) and group (-group).

How to hide errors (like "Permission denied") by redirecting them to /dev/null using 2>/dev/null.
