#!/bin/zsh
OPTIONS="Lock\nSuspend\nLogout\nReboot\nShutdown"
CHOICE=$(echo -e $OPTIONS | rofi -dmenu -i -p "System action:")

case "$CHOICE" in
  Lock) hyprlock ;;  # Or any locking command
  Suspend) systemctl suspend ;;
  Logout) loginctl terminate-session $XDG_SESSION_ID ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
