#!/bin/bash

# Create necessary directories and copy configuration files
mkdir -p ~/.config
cp -r config/* ~/.config/

# Copy wallpapers to the user's wallpapers directory
mkdir -p ~/wallpapers
cp wallpapers/* ~/wallpapers/

# Generate Pywal colors based on the default wallpaper
echo "Running Pywal to generate colors..."
wal -i ~/wallpapers/wallpaper1.jpg

# Copy Wlogout icons if present, otherwise notify the user
echo "Copying Wlogout icons (if present)..."
mkdir -p ~/.config/wlogout
cp config/wlogout/*.png ~/.config/wlogout/ 2>/dev/null || echo "No icons found, download them manually from https://github.com/ArtsyMacaw/wlogout/tree/main/example"

# Copy or create Swaync configs
mkdir -p ~/.config/swaync
if [ ! -f ~/.config/swaync/config.json ]; then
    cp config/swaync/config.json ~/.config/swaync/ || echo "Swaync config not copied, using defaults or manual setup required."
    cp config/swaync/style.css ~/.config/swaync/ || echo "Swaync style not copied, using defaults or manual setup required."
fi

echo "Setup complete! Ensure dependencies and fonts are installed as listed in README.md."