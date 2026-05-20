# Timer & Task Tracker for Hyprland Waybar

A lightweight, clickable timer and task tracker application integrated with your Hyprland waybar status bar.

## Features

- ⏱️ Multiple simultaneous timers with audio notifications
- ✓ Task list management with completion tracking
- 🎨 Clean, modern UI with dark mode support
- 📍 Persistent storage using browser localStorage
- 🖱️ One-click access from waybar status bar
- 🎵 Audio alert when timers complete

## Installation

### Step 1: Setup the React Application

You have two options for running the app:

#### Option A: Using a Local Web Server (Recommended)

1. **Install a lightweight web server** (if you don't have one):
   ```bash
   # Using Python 3
   python3 -m http.server 8000 --directory ~/timer-task-tracker
   
   # Or using Node.js with http-server
   npm install -g http-server
   http-server ~/timer-task-tracker -p 8000
   ```

2. **Create the application directory**:
   ```bash
   mkdir -p ~/timer-task-tracker
   ```

3. **Create an HTML wrapper** (`~/timer-task-tracker/index.html`):
   ```html
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
   ```

4. **Create the app** (`~/timer-task-tracker/app.js`):
   - Copy the React component code from `timer-task-tracker.jsx`
   - Wrap it in a `ReactDOM.render()` call:
   ```javascript
   // At the end of app.js
   ReactDOM.render(<TimerTaskApp />, document.getElementById('root'));
   ```

#### Option B: Using Electron

For a native app experience, you can wrap it with Electron:

```bash
npm init -y
npm install electron
# Then use the HTML file above in your Electron main process
```

### Step 2: Setup the Waybar Module

1. **Copy the waybar script**:
   ```bash
   cp waybar-timer-module.sh ~/.config/waybar/timer-tracker.sh
   chmod +x ~/.config/waybar/timer-tracker.sh
   ```

2. **Edit your waybar config** (`~/.config/waybar/config.jsonc`):
   ```jsonc
   "modules-right": [
     "clock",
     "custom/timer-tracker"
     // ... other modules
   ],

   "custom/timer-tracker": {
     "format": "{}",
     "exec": "~/.config/waybar/timer-tracker.sh status",
     "interval": 1,
     "on-click": "~/.config/waybar/timer-tracker.sh click",
     "tooltip": true,
     "return-type": "json"
   }
   ```

3. **Add styling** to `~/.config/waybar/style.css`:
   ```css
   #custom-timer-tracker {
     padding: 0 10px;
     margin: 0 5px;
     color: #a6e3a1;
     min-width: 40px;
     text-align: center;
   }

   #custom-timer-tracker.timer-active {
     color: #f38ba8;
     animation: blink 1s infinite;
   }

   #custom-timer-tracker.tasks-active {
     color: #94e2d5;
   }

   @keyframes blink {
     0%, 49% { opacity: 1; }
     50%, 100% { opacity: 0.5; }
   }
   ```

### Step 3: Create Autostart Service (Optional)

Create a systemd user service to auto-launch the web server:

**`~/.config/systemd/user/timer-tracker.service`**:
```ini
[Unit]
Description=Timer & Task Tracker Web Server
After=network.target

[Service]
Type=simple
ExecStart=%h/timer-task-tracker/start.sh
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
```

Create `~/timer-task-tracker/start.sh`:
```bash
#!/bin/bash
cd ~/timer-task-tracker
python3 -m http.server 8000
```

Enable and start:
```bash
chmod +x ~/timer-task-tracker/start.sh
systemctl --user enable timer-tracker.service
systemctl --user start timer-tracker.service
```

### Step 4: Launch Configuration

To open the app when clicking the waybar icon, you need a launcher script. Create `~/.local/bin/open-timer-app`:

```bash
#!/bin/bash
# Open in your preferred browser or Electron window
hyprctl dispatch exec "firefox http://localhost:8000 &"

# Or use xdg-open:
# xdg-open http://localhost:8000
```

Make it executable:
```bash
chmod +x ~/.local/bin/open-timer-app
```

Update the waybar script to call this launcher.

## Usage

### From Waybar
- **Click the icon** to open/focus the app
- **Right-click** to edit settings (optional)
- Icon shows:
  - ⏱️ (red/pink, blinking) = timers running
  - ✓ (teal) = tasks in list
  - ⌚ (gray) = idle/no timers or tasks

### In the App
- **Tasks Tab**:
  - Type a task and press Enter or click the + button
  - Check off completed tasks
  - Delete tasks with the trash icon
  - Progress shown at the top

- **Timers Tab**:
  - Enter duration in seconds
  - Click + to start timer
  - Pause/resume with the play/pause button
  - Timer finishes with audio alert
  - Delete with the X button

## Configuration

### Keyboard Shortcuts (to add to Hyprland config)

Add to `~/.config/hypr/hyprland.conf`:
```conf
# Open timer app
bind = SUPER, T, exec, ~/.local/bin/open-timer-app

# Quick timer (5 minutes)
bind = SUPER SHIFT, T, exec, notify-send "Timer started: 5 minutes"
```

### Data Storage

Your tasks and timers are stored in the browser's localStorage:
- Located in your browser's profile directory
- Automatically synced across tabs
- Persists across browser restarts

To export/backup:
1. Open the app in your browser
2. Open Developer Tools (F12)
3. Console: `copy(localStorage.getItem('tasks'))`
4. Paste into a text file to backup

## Troubleshooting

### App won't start
- Check if the web server is running: `ps aux | grep python`
- Check port 8000 is free: `lsof -i :8000`
- Try a different port: `python3 -m http.server 8001`

### Waybar icon doesn't update
- Reload waybar: `killall waybar && waybar`
- Check script permissions: `ls -la ~/.config/waybar/timer-tracker.sh`
- Verify the script path in config is correct

### Audio alerts not working
- Check browser audio permissions
- Try a different browser
- Test with: `python3 -c "import winsound; winsound.Beep(800, 500)"`

### Tasks/Timers not persisting
- Check browser localStorage is enabled
- Clear cache if data seems corrupted
- Check browser storage quota

## Advanced Customization

### Change Colors
Edit the CSS colors in `style.css`. Uses Catppuccin color scheme by default:
- Active timer (pink): `#f38ba8`
- Tasks (teal): `#94e2d5`
- Idle (gray): `#6c7086`

### Add More Presets
In the timers tab, you could add quick preset buttons:
```javascript
const presets = [
  { label: '5 min', seconds: 300 },
  { label: '25 min', seconds: 1500 },
  { label: '1 hour', seconds: 3600 }
];
```

### Sync with Calendar
Integrate with your calendar app to auto-create timers for events (requires additional setup with calendar API).

## Support

For issues or feature requests, check:
- Browser developer console for JavaScript errors
- Waybar logs: `journalctl --user -u waybar -f`
- Script logs: `bash -x ~/.config/waybar/timer-tracker.sh status`

Enjoy! ⏱️✓
