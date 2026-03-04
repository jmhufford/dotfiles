#!/usr/bin/env bash
set -euo pipefail

# Only start if process pattern is not already running.
start_once() {
  if ! pgrep -f "$1" >/dev/null 2>&1; then
    nohup bash -lc "$2" >/dev/null 2>&1 &
  fi
}

# Hyprland might not be fully ready at login.
sleep 2

# Decide profile: weekdays 06:00-18:00 = "work", else "personal".
day="$(date +%u)"   # 1..5=Mon..Fri, 6=Sat, 7=Sun
hour="$(date +%H)"  # 00..23
profile="personal"
if [ "$day" -le 5 ] && [ "$hour" -ge 6 ] && [ "$hour" -lt 18 ]; then
  profile="work"
fi

case "$profile" in
  work)
    # Prefer autossh if available to keep the tunnel alive.
    if command -v autossh >/dev/null 2>&1; then
      start_once "autossh -M 0 -q -D 1080 sai.xemplify.net" \
        "autossh -M 0 -N -q -D 1080 sai.xemplify.net"
    else
      start_once "ssh -q -D 1080 sai.xemplify.net" \
        "ssh -N -q -D 1080 sai.xemplify.net"
    fi

    start_once "kvm" "kvm"
    start_once "google-chrome-stable --proxy-server=socks5://localhost:1080" \
      "google-chrome-stable --proxy-server=\"socks5://localhost:1080\""
    ;;
  personal)
    start_once "discord" "discord"
    start_once "steam" "steam"
    ;;
esac

# Keep focus on primary workspace after startup.
hyprctl dispatch workspace 1 >/dev/null 2>&1 || true
