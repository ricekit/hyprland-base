# Hyprland Ricing Setup

Welcome to my Hyprland ricing setup! This repository contains my configuration files for a sleek, modern, and functional Hyprland desktop environment with a Pywal-themed Waybar, Wlogout power menu, a custom Wofi app launcher, and a semi-transparent Kitty terminal.

## Screenshots
![Desktop](screenshots/desktop.png)
![Waybar](screenshots/waybar.png)
![Wofi](screenshots/wofi.png)
![Kitty](screenshots/kitty.png)
![Wlogout](screenshots/wlogout.png)

## Features
- **Hyprland**: Dynamic tiling with Dwindle layout, smooth animations, and French keyboard support
- **Waybar**: Custom top bar with workspaces, clock, system tray, battery, network, and power menu
- **Hyprlock**: Elegant lock screen with time, date, music info, and battery status
- **Hyprpaper**: Wallpaper management with Pywal integration
- **Hypridle**: Idle management with screen lock and DPMS control
- **Swaync**: Notification center with toggle via Waybar (default config included if not customized)
- **Wlogout**: Stylish power menu for lock, logout, suspend, hibernate, reboot, and shutdown
- **Wofi**: Minimalist app launcher with a dark theme and rounded corners
- **Kitty**: Terminal with a semi-transparent background
- **Custom Keybindings**: Super key-based controls for workspaces, windows, screenshots, and media
- **Theming**: Pywal-generated colors for Waybar, Hyprlock, and Wlogout

## Dependencies
- Hyprland
- Waybar
- Hyprpaper
- Hyprlock
- Hypridle
- Swaync
- Wlogout
- Wofi
- Kitty
- Dolphin (file manager)
- Hyprshot (screenshots)
- Wpctl (audio control)
- Brightnessctl (brightness control)
- Playerctl (media control)
- Pywal (color theming)
- Blueman (Bluetooth)
- NetworkManager (network)
- Pactl (audio volume)
- Yay (AUR helper for updates)
- Fira Sans (Wlogout font)
- CodeNewRoman Nerd Font Propo (Waybar font)
- CaskaydiaCove Nerd Font (Wofi and Kitty font)
- JetBrains Mono (Hyprlock font)
- Font Awesome 6 Free (icons)

## Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/YassIN/hyprland-riced.git
   cd hyprland-riced
2. Run the installation script:
   ```bash
   ./install.sh
3. Restart Hyprland:
   ```bash
    hyprctl reload

## Directory Structure

```
hyprland-riced/
├── config/
│   ├── hypr/
│   │   ├── hyprpaper.conf      # Wallpaper settings
│   │   ├── hypridle.conf       # Idle management
│   │   ├── hyprland.conf       # Main Hyprland config
│   │   └── hyprlock.conf       # Lock screen config
│   ├── waybar/
│   │   ├── config              # Waybar modules
│   │   ├── style.css           # Waybar styling
│   │   └── theme.css           # Waybar color definitions
│   ├── wlogout/
│   │   ├── layout_1            # Wlogout layout with text
│   │   ├── layout.json         # Wlogout minimal layout
│   │   └── style_1.css         # Wlogout styling with Pywal
│   ├── wofi/
│   │   └── style.css           # Wofi styling
│   ├── swaync/ # Swaync configs (default if not customized)
│   │   ├── config.json
│   │   └── style.css
│   └── kitty/
│       └── kitty.conf          # Kitty terminal config
├── wallpapers/
│   └── wallpaper1.jpg          # Default wallpaper
├── screenshots/
│   ├── desktop.png
│   ├── waybar.png
│   ├── wofi.png
│   ├── kitty.png
│   └── wlogout.png
├── install.sh                  # Installation script
├── README.md                   # This file
├── LICENSE                     # MIT License
└── .gitignore                  # Git ignore rules
```


## Keybindings

- uper + A: Launch Kitty terminal
- Super + space: Open Wofi app launcher
- Super + C: Close active window
- Super + V: Toggle floating window
- Super + 1-0: Switch to workspace 1-10
- Super + Shift + 1-0: Move window to workspace 1-10
- Super + Arrows: Move focus
- Print: Take region screenshot
- Super + Print: Take active window screenshot
- Super + ²: Lock screen
- XF86Audio*: Volume and mute controls
- XF86MonBrightness*: Brightness controls
- XF86AudioPlay/Pause/Next/Prev: Media controls

## Waybar Modules

- Left: Notifications, clock, package updates, system tray
- Center: Workspaces with active/inactive indicators
- Right: CPU, memory, audio, backlight, Bluetooth, network, battery, power menu
- Interactions:

    - Click notification icon to toggle Swaync
    - Click power menu (⏻) for Wlogout, right-click to lock
    - Scroll on backlight/audio for adjustments
    - Click package updates to run yay -Syu

## Wlogout Power Menu

- Options: Lock, Log Out, Suspend, Hibernate, Reboot, Shutdown
- Access: Via Waybar power menu (⏻)
- Keybindings: l (lock), e (logout), u (suspend), h (hibernate), r (reboot), s (shutdown)
- Styling: Rounded buttons with Pywal colors

## Wofi App Launcher

- Access: Super + space
- Styling: Dark theme with rounded corners, custom colors, and CaskaydiaCove Nerd Font
- Features: Minimalist design with highlighted selection

## Kitty Terminal

- Access: Super + A
- Styling: Semi-transparent background (70% opacity)
- Features: Simple yet elegant terminal integration

## Customization

- Hyprland: Edit config/hypr/hyprland.conf for keybindings, animations, and window rules.
- Waybar: Modify config/waybar/config for modules, config/waybar/style.css for styling, and config/waybar/theme.css for colors.
- Hyprlock: Adjust config/hypr/hyprlock.conf for lock screen appearance.
- Wlogout: Customize config/wlogout/layout_1 or layout.json for options, and style_1.css for styling.
- Wofi: Adjust config/wofi/style.css for launcher appearance.
- Kitty: Edit config/kitty/kitty.conf for opacity or other settings.
- Swaync: Modify config/swaync/config.json for notification settings and style.css for styling.
- Pywal: Run wal -i <image> to generate new color schemes.
- Wallpapers: Add images to wallpapers/ and update hyprpaper.conf.

## Notes

- Run wal -i <image> to generate ~/.cache/wal/colors-waybar.css for Waybar, Wlogout, and Hyprlock theming.
- French keyboard layout (kb_layout = fr) is used; adjust in hyprland.conf if needed.
- Ensure yay is installed for the package update module.
- Install required fonts for Waybar, Wofi, Kitty, and Hyprlock to render correctly.
- Wlogout icons (lock.png, etc.) are optional; download them from Wlogout examples if needed.
- Swaync uses default configs; customize config/swaync/ if desired.

## Credits

- Hyprland Wiki for configuration guidance
- Pywal for color theming
- Wlogout for power menu
