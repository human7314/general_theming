#!/bin/bash
# Install GTK, cursor, icon, and theme system-wide

# Base directory (where this script lives)
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ">>> Installing theme files from $SRC_DIR"

# --- GTK 2.0 ---
if [ -f "$SRC_DIR/gtk-2.0/gtkrc" ]; then
    echo "[GTK2] Installing gtkrc..."
    sudo mkdir -p /etc/gtk-2.0
    sudo cp -f "$SRC_DIR/gtk-2.0/gtkrc" /etc/gtk-2.0/gtkrc
fi

# --- GTK 3.0 ---
if [ -f "$SRC_DIR/gtk-3.0/settings.ini" ]; then
    echo "[GTK3] Installing settings.ini..."
    sudo mkdir -p /etc/gtk-3.0
    sudo cp -f "$SRC_DIR/gtk-3.0/settings.ini" /etc/gtk-3.0/settings.ini
fi

# --- Cursor theme ---
if [ -d "$SRC_DIR/cursor" ]; then
    echo "[Cursor] Installing cursor theme(s)..."
    sudo cp -rf "$SRC_DIR/cursor/"* /usr/share/icons/
fi

# --- Icon theme ---
if [ -d "$SRC_DIR/icons" ]; then
    echo "[Icons] Installing icon theme(s)..."
    sudo cp -rf "$SRC_DIR/icons/"* /usr/share/icons/
fi

# --- GTK theme ---
if [ -d "$SRC_DIR/themes" ]; then
    echo "[Themes] Installing GTK theme(s)..."
    sudo cp -rf "$SRC_DIR/themes/"* /usr/share/themes/
fi

echo "✅ All done!"
