#!/bin/bash

# Set the name of your Bluetooth speakers
SPEAKER_NAME="YamahaAV"

# Function to check if Bluetooth is on
is_bluetooth_on() {
  bluetooth_status=$(rfkill list bluetooth)
  if [[ $bluetooth_status == *"Soft blocked: no"* && $bluetooth_status == *"Hard blocked: no"* ]]; then
    return 0
  else
    return 1
  fi
}

# Function to check if YamahaAV is connected
is_speaker_connected() {
  devices_info=$(bluetoothctl devices)
  if [[ $devices_info == *"$SPEAKER_NAME"* ]]; then
    return 0
  else
    return 1
  fi
}

# Function to turn on Bluetooth
turn_on_bluetooth() {
  rfkill unblock bluetooth
}

# Function to connect to YamahaAV
connect_speaker() {
  bluetoothctl connect "$SPEAKER_NAME"
}

# Main loop
while true; do
  if ! is_bluetooth_on; then
    echo "Bluetooth is turned off. Turning it on..."
    turn_on_bluetooth
  fi

  if ! is_speaker_connected; then
    echo "$SPEAKER_NAME is not connected. Connecting..."
    connect_speaker
  fi

  sleep 60
done