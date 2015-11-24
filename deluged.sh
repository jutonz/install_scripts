#!/bin/bash

# Kill deluged without also killing this script
kill_deluged() {
  pids=( $(pgrep -f deluged) )
  for pid in "${pids[@]}"; do
    if [[ $pid != $$ ]]; then
      kill "$pid"
    fi
  done
}

kill_deluged # Kill deluged if it is already running

echo "Installing deluge and deluge-console"
sudo apt-get update
sudo apt-get install --yes deluge deluge-console

echo "Setting up configuration file"
deluged
sleep 10 # Allow deluge to create config files
kill_deluged

echo "Creating authorization credentials"
# Backup auth
cd ~/.config/deluge/
cp auth auth.backup

echo "Enter credentials for the user you would like to add"
read -p "Username: " username
read -p "Password: " password
echo "${username}:${password}:10" > auth

echo "Configuring deluged"
deluged
printf "config -s allow_remote True\nexit\n" | deluge-console

echo "Restarting deluge for configuration to take effect"
kill_deluged
deluged

echo "Done! The deluge daemon is now running."

