#!/bin/bash

# Waybar custom module for timer and task tracker
# This script displays timer/task status in waybar and handles clicks

APP_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/timer-task-tracker"
DATA_FILE="$APP_DIR/app-data.json"
WINDOW_CLASS="timer-task-tracker"
APP_WINDOW_ID_FILE="/tmp/timer-task-tracker.wid"

# Initialize data directory
mkdir -p "$APP_DIR"

# Function to initialize empty data if it doesn't exist
init_data() {
  if [ ! -f "$DATA_FILE" ]; then
    echo '{"tasks":[],"timers":[]}' > "$DATA_FILE"
  fi
}

# Function to get active timers count and nearest timer
get_timer_status() {
  init_data
  
  # This is a simplified version - in production you'd parse JSON properly
  local timer_count=$(grep -o '"id"' "$DATA_FILE" 2>/dev/null | wc -l)
  
  if [ "$timer_count" -gt 0 ]; then
    echo "⏱ $timer_count timer$([ $timer_count -eq 1 ] || echo 's')"
  else
    echo ""
  fi
}

# Function to get task status
get_task_status() {
  init_data
  
  local total=$(grep -o '"id"' "$DATA_FILE" 2>/dev/null | wc -l)
  if [ "$total" -gt 0 ]; then
    echo "✓ $total task$([ $total -eq 1 ] || echo 's')"
  else
    echo ""
  fi
}

# Function to launch/focus application window
launch_app() {
  # Check if window already exists
  local existing_wid=$(cat "$APP_WINDOW_ID_FILE" 2>/dev/null)
  
  if [ -n "$existing_wid" ] && xdotool search --id "$existing_wid" 2>/dev/null; then
    # Window exists, toggle visibility
    if xdotool search --id "$existing_wid" | xdotool getactivewindow getwindowname | grep -q "$WINDOW_CLASS"; then
      # Window is active, minimize it
      hyprctl dispatch togglefloating "pid:$(xdotool getwindowpid "$existing_wid" 2>/dev/null)"
    else
      # Window exists but not active, focus it
      xdotool windowactivate "$existing_wid" 2>/dev/null
    fi
  else
    # Window doesn't exist, launch it
    # You can launch it with your preferred method (Electron app, web browser, etc.)
    # For now, this is a placeholder - see setup instructions for actual implementation
    notify-send "Timer & Task Tracker" "Click to open timer and task tracker" -u low
  fi
}

# Main logic
case "${1:-status}" in
  status)
    # Output status for waybar
    timers=$(get_timer_status)
    tasks=$(get_task_status)
    
    # Build tooltip
    tooltip=""
    [ -n "$timers" ] && tooltip="$timers"
    [ -n "$tasks" ] && [ -n "$tooltip" ] && tooltip="$tooltip | $tasks" || [ -n "$tasks" ] && tooltip="$tasks"
    
    if [ -z "$tooltip" ]; then
      tooltip="No active timers or tasks"
    fi
    
    # Output in waybar custom format
    if [ -n "$timers" ]; then
      echo "{\"text\": \"⏱\", \"tooltip\": \"$tooltip\", \"class\": \"timer-active\"}"
    elif [ -n "$tasks" ]; then
      echo "{\"text\": \"✓\", \"tooltip\": \"$tooltip\", \"class\": \"tasks-active\"}"
    else
      echo "{\"text\": \"⌚\", \"tooltip\": \"$tooltip\", \"class\": \"idle\"}"
    fi
    ;;
  
  click)
    launch_app
    ;;
  
  *)
    echo "Usage: $0 {status|click}"
    exit 1
    ;;
esac
