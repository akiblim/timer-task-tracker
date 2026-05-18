# 🚀 Put Your Project on Git - Quick Guide

Everything is ready to push to GitHub, GitLab, or another git hosting service!

## Files Included

| File | Purpose |
|------|---------|
| `README.md` | Main documentation for your GitHub/GitLab repo |
| `LICENSE` | MIT License (open source) |
| `.gitignore` | Tells git which files to ignore |
| `GIT_SETUP.md` | Detailed git setup instructions |
| `setup-git.sh` | Automated git initialization script |

## ⚡ Quickest Path (3 steps)

### Step 1: Run the setup script
```bash
cd /path/to/timer-task-tracker
chmod +x setup-git.sh
./setup-git.sh
```

This will:
- Initialize git locally
- Ask for your name/email
- Stage all files
- Create first commit
- Ask if you want to add a remote (GitHub/GitLab)

### Step 2: Create a repository online
- **GitHub**: Go to github.com → Click + → New repository
- **GitLab**: Go to gitlab.com → Create a project
- **Name it**: `timer-task-tracker`
- **Description**: "A lightweight timer and task tracker for Hyprland waybar"
- **Do NOT** initialize with README/LICENSE (you have them already)

### Step 3: Push to the cloud
```bash
git push -u origin main
```

Done! Your project is on the internet. 🎉

---

## Manual Setup (if you prefer)

If you don't want to use the script:

```bash
# Navigate to project directory
cd timer-task-tracker

# Initialize git
git init

# Set your name and email
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Stage all files
git add .

# Create first commit
git commit -m "Initial commit: Timer and task tracker for Hyprland waybar"

# Rename main branch (GitHub standard)
git branch -M main

# Add remote (GitHub example - replace USERNAME)
git remote add origin https://github.com/USERNAME/timer-task-tracker.git

# Push to remote
git push -u origin main
```

---

## After First Push

### Regular workflow
```bash
# Make changes to your files...

# Check status
git status

# Stage changes
git add .

# Commit
git commit -m "Update: describe your changes"

# Push
git push
```

### Create feature branches
```bash
# Create new branch
git checkout -b feature/new-feature

# Make changes, commit, push
git push -u origin feature/new-feature

# Create Pull Request on GitHub/GitLab to merge back to main
```

---

## Service Comparison

| | GitHub | GitLab | Gitea |
|---|--------|--------|-------|
| **Free tier** | ✅ Public repos free | ✅ Public repos free | Self-hosted |
| **Popularity** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Setup** | Web interface | Web interface | Self-hosted |
| **CI/CD** | GitHub Actions | GitLab CI | Not built-in |
| **Best for** | Most projects | GitOps focused | Privacy/control |

---

## What Each File Does

### `README.md`
- **What**: Your project's main documentation
- **Where**: Shows on your repository's home page
- **Contains**: Features, setup instructions, troubleshooting
- **Edit**: Keep it updated as your project grows

### `LICENSE`
- **What**: MIT Open Source License
- **Why**: Tells people they can use your code
- **Edit**: Only if you want a different license

### `.gitignore`
- **What**: Tells git which files to ignore
- **Why**: Don't commit logs, node_modules, temp files, etc.
- **Edit**: Add more patterns if needed

### `GIT_SETUP.md`
- **What**: Detailed git instructions
- **Contains**: SSH setup, GitHub Pages, troubleshooting
- **Use**: Reference when you need help with git

### `setup-git.sh`
- **What**: Automated setup script
- **Does**: Initializes git, adds files, creates commit
- **Run**: `./setup-git.sh`

---

## Common Tasks

### Push existing changes
```bash
git add .
git commit -m "Your message"
git push
```

### Create and switch to new branch
```bash
git checkout -b feature/my-feature
```

### See commit history
```bash
git log --oneline -10
```

### See what changed
```bash
git diff
git status
```

### Undo last commit (keep changes)
```bash
git reset --soft HEAD~1
```

### Update from remote
```bash
git pull
```

---

## Authentication

### First time pushing?

**Option 1: Personal Access Token (Recommended)**
1. GitHub/GitLab → Settings → Developer settings → Personal access tokens
2. Create token (keep it secret!)
3. When git asks for password, use the token

**Option 2: SSH Key (More Secure)**
1. Generate SSH key: `ssh-keygen -t ed25519`
2. Add public key to GitHub/GitLab settings
3. Use SSH URL instead of HTTPS
4. See `GIT_SETUP.md` for details

**Option 3: git credential helper**
```bash
# Store credentials locally
git config --global credential.helper store
# Then git will remember your credentials
```

---

## Ready to Share!

Once pushed, you can share:
- **GitHub**: `https://github.com/YOUR_USERNAME/timer-task-tracker`
- **GitLab**: `https://gitlab.com/YOUR_USERNAME/timer-task-tracker`

Add to:
- Your portfolio/resume
- Hacker News / Reddit communities
- Developer forums
- Your personal website

---

## Next Steps

1. **Run setup script or manually initialize git**
   ```bash
   chmod +x setup-git.sh
   ./setup-git.sh
   ```

2. **Create repository online** (GitHub/GitLab)

3. **Push to remote**
   ```bash
   git push -u origin main
   ```

4. **Share your project!** 🚀

---

## Troubleshooting

**"fatal: Not a git repository"**
```bash
git init
git add .
git commit -m "Initial commit"
```

**"Permission denied (publickey)"**
- Check you have SSH key set up
- Or use HTTPS URL instead of SSH

**"Updates were rejected"**
```bash
git pull origin main  # Get latest
git push origin main  # Push your changes
```

**Can't remember git commands?**
- See `GIT_SETUP.md` for full reference
- Run `git help` for git documentation
- Use `git status` frequently to check your state

---

## That's it!

Your project is ready to be shared with the world. Good luck! 🎉

For detailed instructions, see:
- **GIT_SETUP.md** - Complete git guide
- **README.md** - Project documentation
- **QUICK_REFERENCE.md** - App quick reference
