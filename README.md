# Timer & Task Tracker for Hyprland Waybar

A lightweight, clickable timer and task tracker application integrated with Hyprland's waybar status bar.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Status](https://img.shields.io/badge/status-active-brightgreen.svg)

## Features

- ⏱️ **Multiple Timers** - Run multiple timers simultaneously with audio notifications
- ✓ **Task Management** - Create, track, and manage your tasks
- 🎨 **Modern UI** - Clean dark theme based on Catppuccin colorscheme
- 📍 **Waybar Integration** - Quick access from your status bar
- 💾 **Persistent Storage** - Auto-saves using browser localStorage
- 🔔 **Live Updates** - Real-time status indicator in waybar
- 🎵 **Audio Alerts** - Notification when timers complete

## Screenshots

```
Tasks Tab:
├─ Add new task
├─ Mark as complete
├─ Delete tasks
└─ Progress counter

Timers Tab:
├─ Create multiple timers
├─ Play/Pause controls
├─ Auto-alert on completion
└─ Real-time countdown
```

## Quick Start

### Prerequisites
- Linux with Hyprland window manager
- Waybar status bar
- Python 3.x
- Web browser (Firefox, Chromium, etc.)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/timer-task-tracker.git
cd timer-task-tracker
```

2. **Run the setup**
```bash
chmod +x quick-setup.sh
./quick-setup.sh
```

3. **Start the server**
```bash
python3 -m http.server 8000 --directory .
```

4. **Access the app**
- Open browser to `http://localhost:8000`
- Or set up waybar integration (see below)

## Setup with Waybar

### 1. Copy waybar module
```bash
cp waybar-timer-module.sh ~/.config/waybar/timer-tracker.sh
chmod +x ~/.config/waybar/timer-tracker.sh
```

### 2. Update waybar config (~/.config/waybar/config.jsonc)

Add to `"modules-right"`:
```jsonc
"custom/timer-tracker"
```

Add the module definition:
```jsonc
"custom/timer-tracker": {
  "format": "{}",
  "exec": "~/.config/waybar/timer-tracker.sh status",
  "interval": 1,
  "on-click": "firefox http://localhost:8000 &",
  "tooltip": true,
  "return-type": "json"
}
```

### 3. Add styling (~/.config/waybar/style.css)
```css
#custom-timer-tracker {
  padding: 0 10px;
  margin: 0 5px;
  color: #a6e3a1;
}

#custom-timer-tracker.timer-active {
  color: #f38ba8;
  animation: blink 1s infinite;
}

@keyframes blink {
  0%, 49% { opacity: 1; }
  50%, 100% { opacity: 0.5; }
}
```

### 4. Update hyprland config (~/.config/hypr/hyprland.conf)
```conf
bind = SUPER, T, exec, firefox http://localhost:8000
```

### 5. Reload waybar
```bash
killall waybar && waybar
```

## Usage

### Tasks Tab
- **Add**: Type task name and press Enter
- **Complete**: Check the checkbox to mark as done
- **Delete**: Click the trash icon
- **Progress**: See completion count at the top

### Timers Tab
- **Create**: Enter duration in seconds and press Enter
- **Control**: Use play/pause button to manage timer
- **Delete**: Click X to remove timer
- **Alert**: Audio notification plays when timer reaches 0

## File Structure

```
timer-task-tracker/
├── index.html                    # Standalone app (ready to use)
├── timer-task-tracker.jsx        # React component
├── waybar-timer-module.sh        # Waybar status script
├── waybar-config-example.jsonc   # Waybar config reference
├── SETUP_GUIDE.md               # Detailed setup instructions
├── QUICK_REFERENCE.md           # Quick reference guide
├── quick-setup.sh               # Automated setup script
└── README.md                    # This file
```

## Configuration

### Auto-start with Systemd

Create `~/.config/systemd/user/timer-tracker.service`:
```ini
[Unit]
Description=Timer Tracker Server
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 -m http.server 8000 --directory %h/timer-task-tracker
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
```

Enable and start:
```bash
systemctl --user enable timer-tracker.service
systemctl --user start timer-tracker.service
```

### Customize Colors

Edit the CSS variables in `index.html`:
```css
:root {
  --color-background-primary: #1e1e2e;
  --color-background-secondary: #313244;
  --color-background-success: #a6e3a1;
  /* ... etc */
}
```

Current theme: **Catppuccin Dark**
- Timer active: `#f38ba8` (pink)
- Tasks: `#a6e3a1` (green)
- Success: `#89b4fa` (blue)

## Data Storage

Tasks and timers are stored in browser localStorage:
- Automatically saved on every change
- Syncs across browser tabs
- Persists across restarts

**To backup your data:**
1. Open the app in your browser
2. Open Developer Tools (F12)
3. In Console, run: `copy(localStorage.getItem('tasks'))`
4. Paste into a text file to backup

## Troubleshooting

### Port 8000 already in use
```bash
# Find and kill existing process
lsof -i :8000 | awk 'NR!=1 {print $2}' | xargs kill

# Or use a different port
python3 -m http.server 8001
```

### Waybar module doesn't update
```bash
# Restart waybar
killall waybar && waybar

# Check script permissions
ls -la ~/.config/waybar/timer-tracker.sh
```

### Tasks/timers not persisting
- Check that browser localStorage is enabled
- Try a different browser
- Check browser storage quota (DevTools → Application → Local Storage)

### Audio alerts not working
- Check browser audio permissions
- Verify system volume is up
- Try a different browser
- Check browser console (F12) for errors

## Development

### Project structure
- **Frontend**: React 18 with vanilla CSS
- **Backend**: Python HTTP server
- **Storage**: Browser localStorage (no server-side DB needed)
- **Dependencies**: None (uses CDN for React)

### Building custom versions

The app is built as a single HTML file with embedded React. To customize:

1. Edit `index.html` to change styles/functionality
2. Modify the React component in the `<script type="text/babel">` section
3. Restart the server to see changes

### Technologies
- React 18 (via CDN)
- Babel (for JSX compilation)
- Tabler Icons (icon library)
- Catppuccin (color theme)
- Python 3 (development server)

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Changelog

### v1.0.0 (Initial Release)
- ✨ Multiple timer support
- ✨ Task management
- ✨ Waybar integration
- ✨ Persistent storage
- ✨ Audio notifications

## Related Projects

- [Hyprland](https://hyprland.org/) - Modern Wayland compositor
- [Waybar](https://github.com/Alexays/Waybar) - Status bar for Wayland
- [Catppuccin](https://catppuccin.com/) - Soothing pastel theme

## Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check SETUP_GUIDE.md for detailed instructions
- See QUICK_REFERENCE.md for quick answers

## Author

Created for Hyprland users who want lightweight, integrated tools.

---

**Made with ❤️ for the Hyprland community**
