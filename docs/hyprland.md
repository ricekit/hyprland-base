# Hyprland Base Configuration Module

This script provides a comprehensive suite of functions designed to modify
and prepare the Hyprland window manager configuration for the Ricekit
environment. It handles several critical tasks:

1. Adding user-specific configuration sources to enable personalization
2. Modularizing the monolithic config file into organized, manageable modules
3. Removing hardware-specific settings that should not be shared across systems
   (such as monitor configurations, input device settings, and per-device configs)
4. Managing permission and security-related configuration directives

These functions work together to create a portable, maintainable Hyprland
configuration that can be shared and version-controlled while preserving
user-specific customizations.

### Available functions

### add_user_config

Appends user-specific configuration file sources to the main Hyprland config.
This enables users to maintain their own personalized settings that will be
loaded after the base configuration, allowing for customization without
modifying the core config files.

The function adds references to two key user configuration files:
  - hyprrice/variables.conf: User-defined variables and settings
  - hyprrice/input.conf: User-specific input device configurations

These files are sourced at the end of hyprland.conf, ensuring user settings
can override default values while keeping customizations separate and portable.


### modularise_config

Divides the monolithic Hyprland configuration file into separate, organized
module files for improved maintainability and clarity. This function extracts
specific configuration sections based on pattern matching and creates
individual files for each logical component of the configuration.

The modularization process involves:
  1. Scanning the main config file for lines matching specific patterns
  2. Extracting matching lines into dedicated module files
  3. Removing extracted lines from the main config file
  4. Adding source directives to load the new module files

Modules created by this function include:
  - autostart: Startup applications and commands (exec/exec-once directives)
  - environment: Environment variables (env directives)
  - permissions: Permission settings and ecosystem configurations
  - general: General appearance and behavior settings
  - decoration: Window decoration, shadows, blur, and visual effects
  - animations: Animation definitions and timing curves
  - workspace-rules: Workspace-specific rules and configurations
  - layout: Tiling layout settings (dwindle/master layout configs)
  - misc: Miscellaneous settings that don't fit other categories
  - gestures: Touchpad and gesture configurations
  - keybinds: Keyboard and mouse binding definitions
  - window-rules: Window-specific rules and behaviors

This modular approach makes it easier to find, edit, and version control
specific aspects of the Hyprland configuration without navigating through
a large monolithic file.


### remove_monitor

Removes all monitor configuration directives from the Hyprland config file.
Monitor configurations are hardware-specific and should not be included in
portable or shared configurations, as they reference specific display devices,
resolutions, refresh rates, and positions that vary between systems.

This function uses sed to delete all lines beginning with "monitor=" from
the main configuration file, ensuring that each user or system can define
their own appropriate monitor settings without conflicts.


### remove_input

Removes the main input configuration block from the Hyprland config file.
The input block contains settings for keyboard, mouse, and touchpad behavior
that are often user-specific or hardware-dependent. This includes sensitivity,
acceleration, natural scrolling preferences, and keyboard repeat rates.

This function searches for the "input {" block and removes everything from
the opening brace through the matching closing brace, ensuring clean removal
of the entire input configuration section without leaving orphaned lines.

Users can then define their own input preferences in a separate file or
through the user-specific configuration mechanism.


### remove_device

Removes all per-device input configuration blocks from the Hyprland config.
Per-device configurations allow fine-grained control over individual input
devices (keyboards, mice, trackpads, etc.) identified by their hardware names
or vendor/product IDs. These are inherently hardware-specific and will not
be applicable or even available on different systems.

This function searches for all "device {" blocks and removes their entire
content, including the opening and closing braces. This ensures that the
configuration doesn't contain references to specific hardware that may not
exist on other systems where the config might be deployed.

Users should configure their specific devices locally rather than including
them in shared or version-controlled configurations.


### remove_permissions

Removes permission configuration directives from the Hyprland config file.
Permission settings control security and access policies for applications
and may be system-specific or environment-specific. These settings might
include window capture permissions, screenshot capabilities, or other
security-sensitive configurations that should be determined per-system.

This function removes all lines containing "permission=" declarations,
allowing each system to define its own appropriate security policies without
inheriting potentially inappropriate or insecure settings from a shared config.


