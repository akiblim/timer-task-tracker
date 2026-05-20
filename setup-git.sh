#!/bin/bash

# Automated Git Setup Script for Timer & Task Tracker
# This script initializes git and sets up your repository

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}"
echo "════════════════════════════════════════════"
echo "  Timer & Task Tracker - Git Setup"
echo "════════════════════════════════════════════"
echo -e "${NC}"
echo ""

# Check if already a git repo
if [ -d .git ]; then
    echo -e "${YELLOW}⚠ This directory is already a git repository${NC}"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
else
    # Get user info
    echo -e "${BLUE}Step 1: Git Configuration${NC}"
    echo "Enter your git configuration (or press Enter to use global settings):"
    echo ""
    
    read -p "Git name (leave blank for global): " git_name
    read -p "Git email (leave blank for global): " git_email
    
    if [ -n "$git_name" ]; then
        git config user.name "$git_name"
        echo -e "${GREEN}✓${NC} User name set: $git_name"
    else
        echo -e "${GREEN}✓${NC} Using global git name"
    fi
    
    if [ -n "$git_email" ]; then
        git config user.email "$git_email"
        echo -e "${GREEN}✓${NC} User email set: $git_email"
    else
        echo -e "${GREEN}✓${NC} Using global git email"
    fi
    
    echo ""
    echo -e "${BLUE}Step 2: Initialize Repository${NC}"
    
    git init
    echo -e "${GREEN}✓${NC} Git repository initialized"
fi

echo ""
echo -e "${BLUE}Step 3: Add Files${NC}"

git add .
echo -e "${GREEN}✓${NC} Files staged for commit"

# Show what will be committed
echo ""
echo "Files to be committed:"
git diff --cached --name-only | sed 's/^/  /'

echo ""
read -p "Commit these files? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Skipping commit."
else
    # Make initial commit
    git commit -m "Initial commit: Timer and task tracker for Hyprland waybar"
    echo -e "${GREEN}✓${NC} Initial commit created"
fi

echo ""
echo -e "${BLUE}Step 4: Remote Repository${NC}"
echo ""
echo "Where do you want to push this repository?"
echo "1) GitHub (https://github.com)"
echo "2) GitLab (https://gitlab.com)"
echo "3) Custom URL"
echo "4) Skip remote setup (can add later)"
echo ""

read -p "Choose option (1-4): " remote_choice

case $remote_choice in
    1)
        echo ""
        read -p "GitHub username: " github_user
        git branch -M main 2>/dev/null || true
        git remote remove origin 2>/dev/null || true
        git remote add origin "https://github.com/${github_user}/timer-task-tracker.git"
        echo -e "${GREEN}✓${NC} Remote added: GitHub"
        echo ""
        echo "To push:"
        echo -e "  ${YELLOW}git push -u origin main${NC}"
        echo ""
        echo "First time? GitHub will ask for authentication:"
        echo "  • Use Personal Access Token (recommended)"
        echo "  • Or set up SSH key (see GIT_SETUP.md)"
        ;;
    2)
        echo ""
        read -p "GitLab username: " gitlab_user
        git branch -M main 2>/dev/null || true
        git remote remove origin 2>/dev/null || true
        git remote add origin "https://gitlab.com/${gitlab_user}/timer-task-tracker.git"
        echo -e "${GREEN}✓${NC} Remote added: GitLab"
        echo ""
        echo "To push:"
        echo -e "  ${YELLOW}git push -u origin main${NC}"
        ;;
    3)
        echo ""
        read -p "Enter full git URL: " custom_url
        git branch -M main 2>/dev/null || true
        git remote remove origin 2>/dev/null || true
        git remote add origin "$custom_url"
        echo -e "${GREEN}✓${NC} Remote added"
        echo ""
        echo "To push:"
        echo -e "  ${YELLOW}git push -u origin main${NC}"
        ;;
    4)
        echo -e "${YELLOW}⚠${NC} Skipped remote setup"
        echo ""
        echo "To add remote later:"
        echo -e "  ${YELLOW}git remote add origin <URL>${NC}"
        echo -e "  ${YELLOW}git push -u origin main${NC}"
        ;;
    *)
        echo -e "${RED}✗ Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${BLUE}Step 5: Summary${NC}"
echo ""
echo "Git configuration:"
git config --local user.name
git config --local user.email

echo ""
echo "Repository status:"
git status

echo ""
echo -e "${GREEN}════════════════════════════════════════════"
echo "✓ Git setup complete!"
echo "════════════════════════════════════════════${NC}"
echo ""
echo "Next steps:"
echo ""
echo "1. Create repository on GitHub/GitLab (if not done)"
echo "2. Push your code:"
echo -e "   ${YELLOW}git push -u origin main${NC}"
echo ""
echo "3. Daily workflow:"
echo -e "   ${YELLOW}git add .${NC}"
echo -e "   ${YELLOW}git commit -m 'Your message'${NC}"
echo -e "   ${YELLOW}git push${NC}"
echo ""
echo "4. Create feature branches:"
echo -e "   ${YELLOW}git checkout -b feature/your-feature${NC}"
echo -e "   ${YELLOW}git push -u origin feature/your-feature${NC}"
echo ""
echo "For more info, see:"
echo "  • GIT_SETUP.md - Detailed git instructions"
echo "  • QUICK_REFERENCE.md - Project quick reference"
echo ""
