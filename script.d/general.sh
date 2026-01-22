# General configuration setup
#
# This script sets up general configuration paths and provides a function to
# replace hardcoded absolute paths in configuration files with a dynamic
# variable. This ensures that Ricekit can adapt the configuration files to point
# to the correct resource locations on the host system.

export WM_CONFIG_DIR="${HOME}/.config/hypr"
export WM_CONFIG_FILE="${WM_CONFIG_DIR}/hyprland.conf"

# Search through all small files (under 500k) in the user's home directory and
# replace hardcoded absolute paths with the ACTIVE_RICEKIT_PATH variable.
# This ensures that configuration files still point to their resources correctly
# on the host system.
#
# The function targets paths that begin with:
#   - "~" (tilde, representing home directory)
#   - Hardcoded paths like "/home/user/Wallpapers"
#
# By replacing these with ${ACTIVE_RICEKIT_PATH}, configurations become
# location-independent and will work correctly without ricekit having to
# install them directly to the home directory of the host system.
find ${HOME} -type f -size "-500k" -exec sed -iE '/^~|^\/app\/rice-in/${ACTIVE_RICEKIT_PATH}/' {} \;