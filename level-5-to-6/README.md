# Bandit Level 5 → Level 6

**Goal:** The password is in the `inhere` directory. The file has 3 properties:
1.  Human-readable
2.  1033 bytes in size
3.  Not executable

---

### 🧰 Commands used

```bash
cd inhere

# Use the 'find' command to find a file with all 3 properties
find . -type f -size 1033c ! -executable

# 'find' will output the path to the file
# We can then 'cat' that file
cat [path-from-find-command]
# -> PASSWORD_REDACTED


💡 What I learned
How to use the find command to search for files.

Using find with specific properties:

-type f (to find files, not directories).

-size 1033c (to find a file that is exactly 1033 bytes).

! -executable (to find a file that is not executable).
