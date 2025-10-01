#!/bin/bash

# ----------------------------------------------------------------
# install-theme.sh — install GTK themes, icons, cursor, Kvantum
# ----------------------------------------------------------------

# Fail-safe: must be run as root (or via sudo)
if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: This script must be run as root (or via sudo)." >&2
    exit 1
fi

# Base directory (where this script lives)
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ">>> Installing theme files from $SRC_DIR"

# --- GTK 2.0 ---
if [ -f "$SRC_DIR/gtk-2.0/gtkrc" ]; then
    echo "[GTK2] Installing gtkrc..."
    mkdir -p /etc/gtk-2.0
    cp -f "$SRC_DIR/gtk-2.0/gtkrc" /etc/gtk-2.0/gtkrc
else
    echo "[GTK2] gtkrc not found, skipping."
fi

# --- GTK 3.0 ---
if [ -f "$SRC_DIR/gtk-3.0/settings.ini" ]; then
    echo "[GTK3] Installing settings.ini..."
    mkdir -p /etc/gtk-3.0
    cp -f "$SRC_DIR/gtk-3.0/settings.ini" /etc/gtk-3.0/settings.ini
else
    echo "[GTK3] settings.ini not found, skipping."
fi

# --- Cursor theme ---
if [ -d "$SRC_DIR/cursor" ]; then
    echo "[Cursor] Installing cursor theme(s)..."
    cp -rf "$SRC_DIR/cursor/"* /usr/share/icons/
else
    echo "[Cursor] No cursor folder found, skipping."
fi

# --- Icon theme ---
if [ -d "$SRC_DIR/icons" ]; then
    echo "[Icons] Installing icon theme(s)..."
    cp -rf "$SRC_DIR/icons/"* /usr/share/icons/
else
    echo "[Icons] No icons folder found, skipping."
fi

# --- GTK theme ---
if [ -d "$SRC_DIR/themes" ]; then
    echo "[Themes] Installing GTK theme(s)..."
    cp -rf "$SRC_DIR/themes/"* /usr/share/themes/
else
    echo "[Themes] No themes folder found, skipping."
fi

# --- Kvantum theme installation ---
# We'll expect in $SRC_DIR a folder "Kvantum" containing one or more theme folders
# and a kvantum.kvconfig.

if [ -d "$SRC_DIR/Kvantum" ]; then
    echo "[Kvantum] Found Kvantum directory."

    # Create global Kvantum directory
    mkdir -p /usr/share/Kvantum

    # Copy theme subfolders (except the config file)
    for sub in "$SRC_DIR/Kvantum"/*; do
        # If it's a directory, copy it
        if [ -d "$sub" ]; then
            echo "  • Copying theme folder $(basename "$sub") to /usr/share/Kvantum"
            cp -rf "$sub" /usr/share/Kvantum/
        fi
    done

    # Install the kvantum.kvconfig if present
    if [ -f "$SRC_DIR/Kvantum/kvantum.kvconfig" ]; then
        echo "[Kvantum] Installing kvantum.kvconfig globally."
        mkdir -p /etc/xdg/Kvantum
        cp -f "$SRC_DIR/Kvantum/kvantum.kvconfig" /etc/xdg/Kvantum/kvantum.kvconfig
    else
        echo "[Kvantum] kvantum.kvconfig not found in Kvantum folder, skipping."
    fi
else
    echo "[Kvantum] No Kvantum folder found, skipping Kvantum theme install."
fi

echo "✅ All done!"
