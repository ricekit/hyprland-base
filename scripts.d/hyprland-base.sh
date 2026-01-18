# Hyprland base
#
## This script contains functions to modify the Hyprland configuration file
## to suit the Ricekit environment. It includes functions to add user-specific
## configurations, modularise the config file, and remove hardware-specific
## settings such as monitor and input device configurations.

add_user_config() {
    # Append user-specific configurations
    echo "source=hyprrice/variables.conf" >> ${HYPRCONFIG_DIR}/hyprland.conf
    echo "source=hyprrice/input.conf" >> ${HYPRCONFIG_DIR}/hyprland.conf
}

modularise_config() {
    # Modularise hyprland config file into seperate files
    module_tuples=(
        "autostart;^exec-once\s*="
        "environment;^env\s*="
        "permissions;^permission\s*=|^ecosystem\s*\{,/^\}"
        "general;^general\s*\{,/^\}"
        "decoration;^decoration\s*\{,/^\}"
        "animations;^animations\s*\{,/^\}"
        "workspace-rules;^workspace\s*="
        "layout;^(dwindle|master)\s*\{,/^\}"
        "misc;^misc\s*\{,/^\}"
        "gestures;^gesture\s*="
        "keybinds;^bind[melr1]*\s*="
        "window-rules;^windowrule\s*\{,/^\}"
    )

    for tuple in "${module_tuples[@]}"; do
        IFS=';' read -r filename pattern <<< "$tuple"
        sed -E -n "/$pattern/d" ${HYPRCONFIG_DIR}/hyprland.conf > ${HYPRCONFIG_DIR}/configs/$filename.conf
        sed -iE "/$pattern/!d" ${HYPRCONFIG_DIR}/hyprland.conf
        echo "source=${HYPRCONFIG_DIR}/configs/$filename.conf" >> ${HYPRCONFIG_DIR}/hyprland.conf
    done
}

remove_monitor() {
    # Remove existing monitor configurations (hardware-specific)
    sed -i '/^monitor\s*=/d' ${HYPRCONFIG_DIR}/hyprland.conf
}

remove_input() {
    # Remove existing input configurations (hardware-specific)
    sed -i '/^input\s*\{/,/^\}/d' ${HYPRCONFIG_DIR}/hyprland.conf
}

remove_device() {
    # Remove per-device input configurations (hardware-specific)
    sed -i '/^device\s*\{/,/^\}/d' ${HYPRCONFIG_DIR}/hyprland.conf
}

remove_permissions() {
    # Remove permission configurations 
    sed -i '/^permission\s*=/d' ${HYPRCONFIG_DIR}/hyprland.conf
}

# Creates the HYPRCONFIG_DIR variable (pointing to the Hyprland config directory) for use in other functions
export HYPRCONFIG_DIR=${HOME}/.config/hypr/
# Replaces hardcoded paths in configuration files with the ACTIVE_RICEKIT_PATH variable 
find ${HOME} -type f -size -1M -exec sed -iE '/^~|^\/app\/rice-in/${ACTIVE_RICEKIT_PATH}/' {} \;