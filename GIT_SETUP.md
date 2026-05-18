# Git Setup Instructions

Follow these steps to push your Timer & Task Tracker project to GitHub, GitLab, or another git hosting service.

## Option 1: GitHub

### 1. Create a new repository on GitHub

1. Go to [github.com](https://github.com)
2. Click the **+** icon in the top right → **New repository**
3. Name it: `timer-task-tracker`
4. Add description: "A lightweight timer and task tracker for Hyprland waybar"
5. Choose **Public** or **Private**
6. **Do NOT** initialize with README (we already have one)
7. Click **Create repository**

### 2. Initialize git locally

```bash
cd /path/to/timer-task-tracker
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

Or set globally:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 3. Add all files

```bash
git add .
git status  # Review what's being added
```

### 4. Make first commit

```bash
git commit -m "Initial commit: Timer and task tracker for Hyprland waybar"
```

### 5. Add remote and push

Replace `YOUR_USERNAME` with your GitHub username:

```bash
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/timer-task-tracker.git
git push -u origin main
```

**Note:** First push may prompt for authentication:
- Use personal access token instead of password (GitHub > Settings > Developer settings > Personal access tokens)
- Or use SSH key (see below)

---

## Option 2: GitLab

### 1. Create a new repository on GitLab

1. Go to [gitlab.com](https://gitlab.com)
2. Click **Create a project** → **Create blank project**
3. Name: `timer-task-tracker`
4. Visibility: **Public** or **Private**
5. **Do NOT** initialize with README
6. Click **Create project**

### 2. Initialize and push

Same as GitHub, but use GitLab URL:

```bash
cd /path/to/timer-task-tracker
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"

git add .
git commit -m "Initial commit: Timer and task tracker for Hyprland waybar"

git branch -M main
git remote add origin https://gitlab.com/YOUR_USERNAME/timer-task-tracker.git
git push -u origin main
```

---

## Option 3: Other Services

Works with Gitea, Forgejo, Gitpod, or your own git server:

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin YOUR_GIT_URL
git push -u origin main
```

---

## Setup SSH Key (Optional but Recommended)

Avoid entering passwords every time:

### 1. Generate SSH key (if you don't have one)

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
# Press Enter for default location and no passphrase (or add one for security)
```

### 2. Add to SSH agent

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### 3. Add public key to GitHub/GitLab

**GitHub:**
1. Go to Settings → SSH and GPG keys → New SSH key
2. Copy your public key: `cat ~/.ssh/id_ed25519.pub`
3. Paste and save

**GitLab:**
1. Go to Settings → SSH Keys
2. Copy your public key: `cat ~/.ssh/id_ed25519.pub`
3. Paste and save

### 4. Use SSH URL for remote

```bash
git remote remove origin  # Remove old HTTPS URL
git remote add origin git@github.com:YOUR_USERNAME/timer-task-tracker.git
git push -u origin main
```

---

## Daily Git Workflow

### Make changes and commit

```bash
# Make changes to files...

# Check what changed
git status
git diff

# Stage changes
git add .
# or specific files:
git add index.html SETUP_GUIDE.md

# Commit
git commit -m "Update: Add more timer features"

# Push to remote
git push
```

### Create feature branches

```bash
# Create and switch to new branch
git checkout -b feature/quick-timers

# Make changes, commit
git add .
git commit -m "Add quick timer preset buttons"

# Push branch
git push -u origin feature/quick-timers

# Create Pull Request on GitHub/GitLab to merge into main
```

### Pull latest changes

```bash
git pull origin main
```

---

## Useful Git Commands

```bash
# View commit history
git log --oneline

# View all branches
git branch -a

# Switch branch
git checkout main

# Delete local branch
git branch -d feature/old-feature

# Undo last commit (keep changes)
git reset --soft HEAD~1

# View changes not yet staged
git diff

# View changes already staged
git diff --cached

# Stash changes temporarily
git stash
git stash pop

# View remote URL
git remote -v
```

---

## Project Structure for Git

Your repository will look like:

```
timer-task-tracker/
├── README.md                    ← Main documentation
├── LICENSE                      ← MIT License
├── .gitignore                   ← Git ignore rules
├── index.html                   ← Standalone app
├── timer-task-tracker.jsx       ← React component
├── waybar-timer-module.sh       ← Waybar script
├── waybar-config-example.jsonc  ← Config example
├── SETUP_GUIDE.md              ← Detailed setup
├── QUICK_REFERENCE.md          ← Quick guide
└── quick-setup.sh              ← Auto setup
```

---

## GitHub Pages (Optional)

To host the app directly on GitHub:

1. Go to repository Settings → Pages
2. Set source to: **main** branch
3. Folder: **root** (or **docs** if you move files)
4. Save

Your app will be available at: `https://YOUR_USERNAME.github.io/timer-task-tracker/`

---

## Troubleshooting

### "fatal: Not a git repository"
```bash
cd /path/to/timer-task-tracker
git init
```

### "Permission denied (publickey)"
- Check SSH key is added to agent: `ssh-add -l`
- Check key is added to GitHub/GitLab settings
- Try HTTPS instead: `git remote set-url origin https://github.com/...`

### "Updates were rejected"
```bash
# Pull latest changes first
git pull origin main
# Then push
git push origin main
```

### Want to change remote URL
```bash
# View current
git remote -v

# Change HTTPS to SSH
git remote set-url origin git@github.com:YOUR_USERNAME/timer-task-tracker.git

# Or back to HTTPS
git remote set-url origin https://github.com/YOUR_USERNAME/timer-task-tracker.git
```

---

## Next Steps

1. Push to GitHub/GitLab (follow above)
2. Add badges to README (optional):
   - Build status
   - License badge
   - Stars badge
3. Consider adding GitHub Issues templates
4. Set up branch protection rules
5. Share the link!

---

## Share Your Project

Once pushed, you can share:

```
GitHub: https://github.com/YOUR_USERNAME/timer-task-tracker
GitLab: https://gitlab.com/YOUR_USERNAME/timer-task-tracker
```

Include in your profile, blogs, communities, forums, etc.

Enjoy sharing your project! 🚀
