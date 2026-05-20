# Timer & Task Tracker - Quick Reference

## 🚀 TL;DR Setup (5 minutes)

### 1. Create App Directory
```bash
mkdir -p ~/timer-task-tracker ~/.config/waybar ~/.local/bin
```

### 2. Copy Files
```bash
# Copy the standalone HTML file
cp index.html ~/timer-task-tracker/

# Copy waybar script
cp waybar-timer-module.sh ~/.config/waybar/timer-tracker.sh
chmod +x ~/.config/waybar/timer-tracker.sh
```

### 3. Start the Server
```bash
cd ~/timer-task-tracker
python3 -m http.server 8000
# Or with nohup for background:
nohup python3 -m http.server 8000 > /tmp/timer-server.log 2>&1 &
```

### 4. Update Waybar Config
Edit `~/.config/waybar/config.jsonc` and add to `"modules-right"`:
```jsonc
"custom/timer-tracker"
```

Then add the module definition:
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

### 5. Update Hyprland Config
Add to `~/.config/hypr/hyprland.conf`:
```conf
bind = SUPER, T, exec, firefox http://localhost:8000
```

### 6. Reload
```bash
killall waybar && waybar
# or manually restart hyprland
```

Done! Press Super+T or click the waybar icon to open the app.

---

## 📁 Files Included

| File | Purpose |
|------|---------|
| `index.html` | Complete standalone app - ready to use immediately |
| `timer-task-tracker.jsx` | React component (for custom integration) |
| `waybar-timer-module.sh` | Waybar status module script |
| `waybar-config-example.jsonc` | Configuration examples |
| `SETUP_GUIDE.md` | Detailed setup instructions |
| `quick-setup.sh` | Automated setup script |

---

## 🎮 Usage

### Tasks Tab
- **Add**: Type task name + Enter or click +
- **Complete**: Check the checkbox
- **Delete**: Click trash icon
- Shows progress (X of Y completed)

### Timers Tab
- **Add**: Enter seconds + Enter or click +
- **Control**: Play/pause with button
- **Delete**: Click X
- **Alert**: Audio notification when done

---

## 🔧 Browser Options

Replace `firefox` in above steps with your preferred browser:
- `firefox` - Firefox (recommended)
- `chromium` or `google-chrome` - Chromium-based
- `xdg-open` - System default

---

## 📍 Waybar Icon Behavior

- **⏱️ (blinking red)** = Timer(s) running
- **✓ (teal)** = Tasks in list  
- **⌚ (gray)** = Idle (no timers/tasks)

Click to open/focus, right-click for options (customize as needed).

---

## 💾 Data Storage

- Stored in browser localStorage automatically
- Syncs across tabs
- Persists across browser restarts
- **To backup**: Dev Tools (F12) → Console → `copy(localStorage.getItem('tasks'))`

---

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| Port 8000 in use | Kill existing: `lsof -i :8000 \| awk 'NR!=1 {print $2}' \| xargs kill` |
| Waybar doesn't update | Restart waybar: `killall waybar && waybar` |
| App won't launch | Check Python is installed: `python3 --version` |
| No audio alerts | Check browser audio, try different browser |
| Timer/tasks lost | Check localStorage: Dev Tools → Application → Local Storage |

---

## 🎨 Customization

### Colors (Edit index.html `<style>`)
Current theme: Catppuccin (dark)
- Timer: `#f38ba8` (pink)
- Tasks: `#a6e3a1` (green)
- Success: `#89b4fa` (blue)

### CSS Variables in index.html
```css
--color-background-primary: #1e1e2e
--color-background-secondary: #313244
--color-background-success: #a6e3a1
--color-text-primary: #cdd6f4
```

### Quick Timer Presets
Add to "Timers Tab" input area (requires HTML editing):
```html
<button onclick="setTimerInput(300)">5min</button>
<button onclick="setTimerInput(900)">15min</button>
<button onclick="setTimerInput(1800)">30min</button>
```

---

## ⌨️ Keyboard Shortcuts

### App Shortcuts
- **Enter** in task/timer input = Add item
- **Tab** = Move between inputs
- **Escape** = (close if full-screen, would need custom config)

### Hyprland Integration (add to hyprland.conf)
```conf
# Open app
bind = SUPER, T, exec, firefox http://localhost:8000

# Quick timers
bind = SUPER SHIFT, 1, exec, notify-send 'Timer: 5 min'
bind = SUPER SHIFT, 2, exec, notify-send 'Timer: 25 min'
```

---

## 🔌 Advanced: Systemd Autostart

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
systemctl --user status timer-tracker.service
```

---

## 📊 Waybar Styling

Add to `~/.config/waybar/style.css`:
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

---

## 🔗 Related Tools

Work great with this setup:
- **Hyprland**: Window manager
- **Waybar**: Status bar
- **Firefox/Chromium**: App container
- **dmenu/rofi**: App launcher (optional)

---

## 📝 Notes

- App requires Python 3 for the server (comes with most Linux distros)
- Works with any Wayland compositor (Hyprland, Sway, Gnome 4.2+)
- Tested on Catppuccin colorscheme, adapts to light/dark modes
- No external dependencies except Python + browser
- ~50KB total size (minimal resource usage)

---

## 🎯 Next Steps

After setup:
1. Test by pressing Super+T
2. Create a task and timer to test functionality
3. Configure keyboard shortcuts in hyprland.conf
4. Customize colors/styling if desired
5. (Optional) Set up systemd autostart for server

Enjoy! ⏱️✓
