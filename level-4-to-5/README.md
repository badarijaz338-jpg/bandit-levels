# Bandit Level 4 → Level 5

**Goal:** The password is in the `inhere` directory and is the only human-readable file.

---

### 🧰 Commands used

```bash
ls
cd inhere
file ./*
# The output showed -file07 was 'ASCII text' (or similar)
cat ./-file07
# -> PASSWORD_REDACTED


💡 What I learned
How to use the file command to determine a file's type.

How to use the * wildcard to run a command on all files in a directory.

Combining tricks: using ./* to use a wildcard on files that start with a dash.
