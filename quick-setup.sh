#!/bin/bash
# Quick setup script for Timer & Task Tracker

set -e

echo "🚀 Timer & Task Tracker - Quick Setup"
echo "====================================="
echo ""

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Create directories
echo -e "${BLUE}[1/5]${NC} Creating directories..."
mkdir -p ~/timer-task-tracker
mkdir -p ~/.config/waybar
mkdir -p ~/.local/bin
mkdir -p ~/.config/systemd/user

# Step 2: Copy React app
echo -e "${BLUE}[2/5]${NC} Setting up React application..."

# Create HTML wrapper
cat > ~/timer-task-tracker/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Timer & Task Tracker</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      background: #1e1e2e;
      color: #cdd6f4;
      line-height: 1.6;
    }
    :root {
      --color-background-primary: #1e1e2e;
      --color-background-secondary: #313244;
      --color-background-tertiary: #45475a;
      --color-background-info: #89b4fa;
      --color-background-success: #a6e3a1;
      --color-background-warning: #f9e2af;
      --color-background-danger: #f38ba8;
      --color-text-primary: #cdd6f4;
      --color-text-secondary: #bac2de;
      --color-text-tertiary: #a6adc8;
      --color-text-info: #1e1e2e;
      --color-text-success: #1e1e2e;
      --color-border-tertiary: rgba(205, 214, 244, 0.15);
      --color-border-secondary: rgba(205, 214, 244, 0.3);
      --color-border-primary: rgba(205, 214, 244, 0.4);
      --border-radius-md: 8px;
      --border-radius-lg: 12px;
      --font-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    }
  </style>
</head>
<body>
  <div id="root"></div>
  <script crossorigin src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
  <script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/7.23.5/babel.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons@latest/tabler-icons.min.css">
  <script type="text/babel" src="app.js"></script>
</body>
</html>
EOF

# Create app.js - you'll need to place the React component here
echo "// React app will be placed here" > ~/timer-task-tracker/app.js
echo -e "${GREEN}✓${NC} HTML wrapper created at ~/timer-task-tracker/"

# Step 3: Copy waybar script
echo -e "${BLUE}[3/5]${NC} Setting up waybar module..."

if [ -f "./waybar-timer-module.sh" ]; then
  cp waybar-timer-module.sh ~/.config/waybar/timer-tracker.sh
  chmod +x ~/.config/waybar/timer-tracker.sh
  echo -e "${GREEN}✓${NC} Waybar script installed"
else
  echo -e "${YELLOW}⚠${NC} waybar-timer-module.sh not found in current directory"
  echo "  You'll need to copy it manually to ~/.config/waybar/timer-tracker.sh"
fi

# Step 4: Create launcher script
echo -e "${BLUE}[4/5]${NC} Creating launcher script..."

cat > ~/.local/bin/open-timer-app << 'EOF'
#!/bin/bash
# Open Timer & Task Tracker
# Adjust the command below based on your preferred browser or app launcher

# Option 1: Firefox
firefox "http://localhost:8000" > /dev/null 2>&1 &

# Option 2: Chromium
# chromium "http://localhost:8000" > /dev/null 2>&1 &

# Option 3: Default browser
# xdg-open "http://localhost:8000"
EOF

chmod +x ~/.local/bin/open-timer-app
echo -e "${GREEN}✓${NC} Launcher script created at ~/.local/bin/open-timer-app"

# Step 5: Create start script
echo -e "${BLUE}[5/5]${NC} Creating server startup script..."

cat > ~/timer-task-tracker/start.sh << 'EOF'
#!/bin/bash
cd ~/timer-task-tracker
echo "Starting Timer & Task Tracker on http://localhost:8000"
python3 -m http.server 8000 --directory .
EOF

chmod +x ~/timer-task-tracker/start.sh
echo -e "${GREEN}✓${NC} Startup script created"

# Summary
echo ""
echo -e "${GREEN}====================================="
echo "✓ Setup Complete!"
echo "=====================================${NC}"
echo ""
echo "Next steps:"
echo ""
echo "1. Copy your React component to the app.js file:"
echo -e "   ${YELLOW}cat timer-task-tracker.jsx >> ~/timer-task-tracker/app.js${NC}"
echo ""
echo "2. Start the web server:"
echo -e "   ${YELLOW}~/timer-task-tracker/start.sh${NC}"
echo "   (Or set up the systemd service for autostart)"
echo ""
echo "3. Update your waybar config (~/.config/waybar/config.jsonc):"
echo "   See SETUP_GUIDE.md for the configuration snippet"
echo ""
echo "4. Update your hyprland config (~/.config/hypr/hyprland.conf):"
echo "   Add: ${YELLOW}bind = SUPER, T, exec, ~/.local/bin/open-timer-app${NC}"
echo ""
echo "5. Install the React component properly:"
echo "   Edit ~/timer-task-tracker/app.js and add:"
echo "   - The TimerTaskApp component from timer-task-tracker.jsx"
echo "   - A ReactDOM.render() call at the end"
echo ""
echo "Documentation: See SETUP_GUIDE.md for detailed instructions"
echo ""
