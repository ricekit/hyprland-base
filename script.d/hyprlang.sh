## Hyprlang helper functions
#
# These functions assist in modifying the configuration files using hyprlang
# syntax. They provide a way to remove entire configuration blocks or specific
# assignments from the Hyprland configuration file.
#

# Removes a configuration block from the Hyprland config file.
#
# # Arguments:
#   $1 - The name of the block to remove (e.g., "input", "monitor", "device").
remove_hyprlang_block() {
    sed -Ei "/^$1\s*\{/,/^\}/d" "${HYPRCONFIG_DIR}/hyprland.conf"
}

# Removes a specific assignment from the Hyprland config file.
#
# # Arguments:
#   $1 - The name of the assignment to remove (e.g., "permission", "monitor").
remove_hyprlang_assign() {
    sed -Ei "/^$1\s*=/d" "${HYPRCONFIG_DIR}/hyprland.conf"
}
