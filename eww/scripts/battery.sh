#!/usr/bin/env bash

BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1)
CAP=$(cat /sys/class/power_supply/${BAT}/capacity)
STAT=$(cat /sys/class/power_supply/${BAT}/status)

if [[ $1 == "--status" ]]; then
  echo "$STAT"
else
  if [[ $CAP -le 10 && $STAT == "Discharging" ]]; then
    notify-send "Low battery ($CAP%)"
  fi
  echo "$CAP"
fi
