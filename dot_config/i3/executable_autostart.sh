#!/usr/bin/env bash
set -euo pipefail

# Helper: only start if not already running
start_once() {
  if ! pgrep -f "$1" >/dev/null 2>&1; then
    nohup bash -lc "$2" >/dev/null 2>&1 &
  fi
}

# Decide profile: weekdays 06:00–18:00 = "work", else "personal"
day="$(date +%u)"   # 1..5=Mon..Fri, 6=Sat, 7=Sun
hour="$(date +%H)"  # 00..23
profile="personal"
if [ "$day" -le 5 ] && [ "$hour" -ge 6 ] && [ "$hour" -lt 18 ]; then
  profile="work"
fi

# Common things (runs in both profiles)
# Give X a moment to settle, then place workspaces/outputs

case "$profile" in
  work)
    # Work profile
    i3-msg -q 'workspace 3'
    # Prefer autossh if available to keep the tunnel alive
    if command -v autossh >/dev/null 2>&1; then
      start_once "autossh -M 0 -q -D 1080 sai.xemplify.net" \
        "autossh -M 0 -N -q -D 1080 sai.xemplify.net"
    else
      start_once "ssh -q -D 1080 sai.xemplify.net" \
        "ssh -N -q -D 1080 sai.xemplify.net"
    fi

    start_once "kvm" "kvm"

    # Browser with SOCKS proxy
    start_once "google-chrome-stable --proxy-server=socks5://localhost:1080" \
      "google-chrome-stable --proxy-server=\"socks5://localhost:1080\""
    ;;
  personal)
    # Add Discord
    i3-msg -q 'workspace 4'
    start_once "discord" "discord"

    # Add Steam
    i3-msg -q 'workspace 5'
    start_once "steam" "steam"
    ;;
esac

# Return to your primary workspace when done
i3-msg -q 'workspace 1'

