# Wofi configuration helper functions
#
# This script provides functions to manage Wofi/Rofi configuration files,
# allowing for modularization and user-specific customization.

WOFI_CONFIG_DIR="${HOME}/.config/wofi"
WOFI_CONFIG_FILE="${WOFI_CONFIG_DIR}/config"

# Converts a rofi configuration for use with wofi
wofi_convert_rofi_config() {
    mv ${HOME}/.config/rofi ${HOME}/.config/wofi
    sed -iE 's/rofi/wofi/g' ${WM_CONFIG_FILE}
}