#!/bin/bash

# Prompt for the email associated with your GitHub account
read -p "Enter your GitHub email address: " email

# Check if the .ssh directory exists; if not, create it
if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi

# Generate a new SSH key using the Ed25519 algorithm
ssh-keygen -t ed25519 -C "$email" -f "$HOME/.ssh/id_ed25519" -N ""

# Start the SSH agent if it's not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)"
fi

# Add the new SSH key to the SSH agent
ssh-add "$HOME/.ssh/id_ed25519"

# Display the public key and instructions for adding it to GitHub
echo -e "\nYour new SSH public key has been generated and added to the SSH agent."
echo "Copy the following public key and add it to your GitHub account:"
echo -e "\n$(cat "$HOME/.ssh/id_ed25519.pub")"
echo -e "\nTo add the key to your GitHub account:"
echo "1. Log in to your GitHub account."
echo "2. Click on your profile picture in the upper-right corner and select 'Settings'."
echo "3. In the left sidebar, click on 'SSH and GPG keys'."
echo "4. Click the 'New SSH key' button."
echo "5. Provide a descriptive title for the key (e.g., 'Personal Laptop') and paste the copied key into the 'Key' field."
echo "6. Click 'Add SSH key'."
